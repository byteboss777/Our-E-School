import "dart:async";
import 'dart:io';
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter/services.dart';
// import "package:google_sign_in/google_sign_in.dart";
import "package:ourESchool/core/Models/User.dart";
import "package:ourESchool/core/Models/UserDataLogin.dart";
import 'package:ourESchool/core/enums/AuthErrors.dart';
import 'package:ourESchool/core/enums/LoginScreenReturnType.dart';
import "package:ourESchool/core/enums/UserType.dart";
import 'package:ourESchool/core/helpers/shared_preferences_helper.dart';
import 'package:ourESchool/core/services/Services.dart';
import 'package:ourESchool/locator.dart';

class AuthenticationServices extends Services {
  SharedPreferencesHelper _sharedPreferencesHelper =
      locator<SharedPreferencesHelper>();
  // Future handleGoogleSignIn() async {
  //   try {
  //     AuthCredential credential;
  //     final GoogleSignInAccount googleUser = await _googleSignIn.signIn().catchError((e) {
  //       throw e;
  //     });
  //     await googleUser.authentication.then((onValue) async {
  //       credential = GoogleAuthProvider.getCredential(
  //         accessToken: onValue.accessToken,
  //         idToken: onValue.idToken,
  //       );
  //       _firebaseUser = await _auth.signInWithCredential(credential);
  //     });
  //     print("signed in " + _firebaseUser.displayName);
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  // }

  bool isUserLoggedIn = false;
  UserType userType = UserType.STUDENT;

  AuthenticationServices() {
    _isLoggedIn().then((onValue) => isUserLoggedIn = onValue);
  }

  Future<bool> _isLoggedIn() async {
    firebaseUser = await auth.currentUser();
    return firebaseUser == null ? false : true;
  }

  Future<UserType> _userType() async {
    userType = await _sharedPreferencesHelper.getUserType();
    return userType;
  }

  Future checkDetails({
    @required String schoolCode,
    @required String email,
    @required String password,
    @required UserType userType,
  }) async {
    //Check if the School code is present and return "School not Present" if not
    //Then check if the user credentials are in the database or not
    //if not then return "Student Not Found" else return "Logging in"
    String country = "India";
    //Api Call to check details
    bool isSchoolPresent = false;
    bool isUserAvailable = false;
    String loginType = userType == UserType.STUDENT
        ? "Student"
        : userType == UserType.TEACHER ? "Parent-Teacher" : "Parent-Teacher";

    DocumentReference _schoolRef = firestore
        .collection("Schools")
        .document(country)
        .collection(schoolCode.toUpperCase().trim())
        .document('Login');

    await _schoolRef.get().then((onValue) {
      isSchoolPresent = onValue.exists;
      print("Inside Then :" + onValue.data.toString());
    });

    if (!isSchoolPresent) {
      print('School Not Found');
      return ReturnType.SCHOOLCODEERROR;
    } else {
      print('School Found');
    }

    CollectionReference _userRef = _schoolRef.collection(loginType);

    await _userRef
        .where("email", isEqualTo: email)
        .snapshots()
        .first
        .then((querySnapshot) {
      querySnapshot.documents.forEach((documentSnapshot) {
        isUserAvailable = documentSnapshot.exists;
        print("User Data : " + documentSnapshot.data.toString());
        if (userType == UserType.STUDENT) {
          userDataLogin = UserDataLogin(
            email: documentSnapshot["email"].toString(),
            id: documentSnapshot["id"].toString(),
          );
        } else {
          userDataLogin = UserDataLogin(
            email: documentSnapshot["email"].toString(),
            id: documentSnapshot["id"].toString(),
            isATeacher: documentSnapshot["isATeacher"] as bool,
            childIds: documentSnapshot["childId"] as List<dynamic>,
          );
        }
      });
    });

    if (!isUserAvailable) {
      print('User Not Found');
      return ReturnType.EMAILERROR;
    } else {
      print('User Found');
    }

    print("Childs :" + userDataLogin.childIds.toString());
    print("Email :" + userDataLogin.email);
    print("Id :" + userDataLogin.id);
    print("isATeacher :" + userDataLogin.isATeacher.toString());

    return ReturnType.SUCCESS;
  }

  Future emailPasswordRegister(
      String email, String password, UserType userType) async {
    try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      authErrors = AuthErrors.SUCCESS;
      print("User Regestered using Email and Password");
      _sharedPreferencesHelper.setUserType(userType);

      return authErrors;
    } catch (e) {
      return catchException(e);
    }
  }

  Future<AuthErrors> emailPasswordSignIn(
      String email, String password, UserType userType) async {
    try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      authErrors = AuthErrors.SUCCESS;
      print("User Loggedin using Email and Password");
      _sharedPreferencesHelper.setUserType(userType);
      return authErrors;
    } on PlatformException catch (e) {
      return catchException(e);
    }
  }

  Future<User> fetchUserData() async {
    FirebaseUser user = await auth.currentUser();
    if (user == null) {
      print("No User LogedIn");
      return null;
    }
    User userr = User(
      displayName: user.displayName,
      mobileNo: user.phoneNumber,
      email: user.email,
      firebaseUuid: user.uid,
      isVerified: user.isEmailVerified,
      photoUrl: user.photoUrl,
    );
    print(userr.toString());
    return userr;
  }

  logoutMethod() async {
    await auth.signOut();
    await _sharedPreferencesHelper.removeUserType();
    print("User Loged out");
  }

  Future<AuthErrors> passwordReset(String email) async {
    try {
      AuthErrors authErrors = AuthErrors.UNKNOWN;
      await auth.sendPasswordResetEmail(email: email);
      authErrors = AuthErrors.SUCCESS;
      print("Password Reset Link Send");
      return authErrors;
    } on PlatformException catch (e) {
      return catchException(e);
    }
  }

  AuthErrors catchException(Exception e) {
    AuthErrors errorType = AuthErrors.UNKNOWN;
    if (e is PlatformException) {
      if (Platform.isIOS) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = AuthErrors.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = AuthErrors.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = AuthErrors.NetworkError;
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isAndroid) {
        switch (e.code) {
          case 'Error 17011':
            errorType = AuthErrors.UserNotFound;
            break;
          case 'Error 17009':
            errorType = AuthErrors.PasswordNotValid;
            break;
          case 'Error 17020':
            errorType = AuthErrors.NetworkError;
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      }
    }

    print('The error is $errorType');
    return errorType;
  }
}
