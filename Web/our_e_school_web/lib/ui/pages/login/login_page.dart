import 'package:flutter/material.dart';
import 'package:oureschoolweb/ui/components/Resources.dart';
import 'package:oureschoolweb/ui/components/color.dart';
import 'package:oureschoolweb/ui/components/footer.dart';
import 'package:oureschoolweb/ui/components/MenuBar/menuBar.dart';
import 'package:oureschoolweb/ui/components/styles.dart';
import 'package:oureschoolweb/ui/components/text.dart';
import 'package:oureschoolweb/ui/components/typography.dart';
import 'package:oureschoolweb/ui/helper/Enums.dart';
import 'package:oureschoolweb/ui/pages/login/login_page_view_model.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
              MenuBar(
                selectedPage: SelectedPage.LOGIN,
              ),
              ResponsiveLoginUI(),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveLoginUI extends StatelessWidget {
  const ResponsiveLoginUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveWrapper.of(context).equals(MOBILE) || ResponsiveWrapper.of(context).isSmallerThan(MOBILE)) {
          return MobileLoginUI();
        } else if (ResponsiveWrapper.of(context).equals(TABLET)) {
          return TabletLoginUI();
        } else {
          return DesktopLoginUI();
        }
      },
    );
  }
}

class MobileLoginUI extends StatelessWidget {
  const MobileLoginUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 500,
          child: Card(
            elevation: 10,
            color: kmainColorParents.withOpacity(0.7),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      ImageAssets.login_image2x,
                      fit: BoxFit.fitWidth,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Container(
                  child: LoginForm(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DesktopLoginUI extends StatelessWidget {
  const DesktopLoginUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          flex: 8,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Card(
              elevation: 0,
              // color: Colors.blueGrey,
              child: Image.asset(
                ImageAssets.login_image2x,
                fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 12,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Card(
              elevation: 10,
              color: kmainColorParents,
              child: LoginForm(),
            ),
          ),
        ),
      ],
    );
  }
}

class TabletLoginUI extends StatelessWidget {
  const TabletLoginUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Stack(
                children: [
                  Positioned(
                    left: -50,
                    right: 10,
                    top: 10,
                    bottom: 10,
                    child: Image.asset(
                      ImageAssets.login_image2x,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 10,
              color: kmainColorParents,
              child: LoginForm(),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginPageViewModel>.reactive(
        viewModelBuilder: () => LoginPageViewModel(),
        builder: (context, model, child) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 40),
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextBodyExtraLarge(
                      text: "SIGNIN",
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: TextField(
                    onChanged: (schoolCode) {},
                    keyboardType: TextInputType.text,
                    style: bodyTextStyle(context, color: Colors.white),
                    decoration: kTextFieldDecorationWithIcon(context,
                            icon: Icons.school)
                        .copyWith(
                      hintText: StringConstants.school_name_code_hint,
                      labelText: StringConstants.school_name_code,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: TextField(
                    onChanged: (email) {},
                    keyboardType: TextInputType.emailAddress,
                    style: bodyTextStyle(context, color: Colors.white),
                    decoration:
                        kTextFieldDecorationWithIcon(context, icon: Icons.email)
                            .copyWith(
                      hintText: StringConstants.email_hint,
                      labelText: StringConstants.email,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 200,
                  ),
                  child: TextField(
                    onChanged: (password) {},
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    style: bodyTextStyle(context, color: Colors.white),
                    decoration: kTextFieldDecorationWithIcon(
                      context,
                      icon: Icons.vpn_key,
                    ).copyWith(
                      hintText: StringConstants.password_hint,
                      labelText: StringConstants.password,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                        maxWidth: 400, minWidth: 200, minHeight: 80),
                    child: FlatButton(
                      hoverColor: Colors.redAccent.shade700,
                      color: Colors.redAccent,
                      onPressed: () {
                        model.navigateToAddUser();
                      },
                      child: Center(
                        child: TextHeadlineSecondary(
                          text: StringConstants.login.toUpperCase(),
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          );
        });
  }
}
