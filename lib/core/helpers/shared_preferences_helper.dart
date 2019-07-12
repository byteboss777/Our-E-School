import 'package:ourESchool/core/enums/UserType.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  final String _kCountryCodePrefs = "countryCode";
  final String _kCountryNamePrefs = "countryName";
  final String _userType = 'userType';
  final String _loggedInUserId = '_loggedInUserId';

  //Method that saves the _loggedInUserId
  Future<bool> setLoggedInUserId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.setString(_loggedInUserId, id);
    print('User Id Saved' + res.toString());
    return res;
  }

  //Method that return the _loggedInUserId
  Future<String> getLoggedInUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String res = prefs.getString(_loggedInUserId);
    print('User Id Retrived' + res.toString());
    return res;
  }

  // Method to remove userType when logging out
  Future<bool> _removeLoggedInUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.remove(_loggedInUserId);
    print('LoggedInUserId Removed : ' + res.toString());
    return res;
  }

  //Method that saves the user logged in type
  Future<bool> setUserType(UserType userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res =
        await prefs.setString(_userType, UserTypeHelper.getValue(userType));
    print('User Type Saved' + res.toString());
    return res;
  }

  //Method that return the user logged in type
  Future<UserType> getUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userType =
        prefs.getString(_userType) ?? UserTypeHelper.getValue(UserType.UNKNOWN);
    print('User Type Returned' + userType);
    return UserTypeHelper.getEnum(userType);
  }

  // Method to remove userType when logging out
  Future<bool> _removeUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.remove(_userType);
    print('UserType Removed : ' + res.toString());
    return res;
  }

  //Method to remove all the Sharedpreference details when Logging Out
  Future<bool> clearAllData() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    bool res = await preferences.clear();
    print('User Data Cleared : ' + res.toString());

    return res;
  }

  // Method that returns the last selected country code
  Future<String> getCountryCode() async {
    final SharedPreferences countryCodePrefs =
        await SharedPreferences.getInstance();

    return countryCodePrefs.getString(_kCountryCodePrefs) ?? "IN";
  }

  // Method that saves the last selected country code
  Future<bool> setCountryCode(String countryCode) async {
    final SharedPreferences countryCodePrefs =
        await SharedPreferences.getInstance();

    return countryCodePrefs.setString(_kCountryCodePrefs, countryCode);
  }

  // Method that returns the last selected country name
  Future<String> getCountryName() async {
    final SharedPreferences countryNamePrefs =
        await SharedPreferences.getInstance();

    return countryNamePrefs.getString(_kCountryNamePrefs) ?? 'India';
  }

  // Method that saves the last selected country name
  Future<bool> setCountryName(String countryName) async {
    final SharedPreferences countryNamePrefs =
        await SharedPreferences.getInstance();

    return countryNamePrefs.setString(_kCountryNamePrefs, countryName);
  }
}
