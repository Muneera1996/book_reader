import 'package:book_reader/components/custom_app_bar.dart';
import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/components/title_text.dart';
import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/pages/app_sign_up.dart';
import 'package:book_reader/pages/home_screen.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/themes/theme.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/GoogleSignInProvider.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:book_reader/utils/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:provider/provider.dart';

import '../components/text_field_widget.dart';

class AppSignIn extends StatefulWidget {
  const AppSignIn({super.key});

  @override
  _AppSignInState createState() => _AppSignInState();
}

class _AppSignInState extends State<AppSignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();

  final _signInKey = GlobalKey<FormState>();
  AppSharedPreferences? sharedPreferences;


  @override
  void initState() {
    super.initState();
    AppSharedPreferences.getPreferencesInstance().then((value) {
      sharedPreferences = value;
      setState(() {
        emailController.text = sharedPreferences?.getEmail()??"";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: Builder(
          builder: (context) => Form(
            key: _signInKey,
            child: Container(
             color: theme.colorScheme.background,
              child: ListView(
                padding: AppTheme.aPadding * 4,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  const TitleText(
                    text: 'Enter your login credentials to start your session.',
                    color: LightColor.black,
                    fontSize: 17,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      type: TextInputType.emailAddress,
                      textEditingController: emailController,
                      labelText: 'Email',
                      iconData: FontAwesomeIcons.envelope,
                      errorText: 'Email'),
                  TextFieldWidget(
                      type: TextInputType.visiblePassword,
                      textEditingController: passwordController,
                      labelText: 'Password',
                      iconData: FontAwesomeIcons.userLock,
                      errorText: 'Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ButtonWidget(
                          text: 'Login',
                          onPressed: () => _login(context),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: ButtonWidget(
                              text: 'Register',
                              color: LightColor.lightGrey,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AppSignUp()))))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: TitleText(
                        text: "OR",
                        color: LightColor.black,
                        fontWeight: FontWeight.w300),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      User? user =
                          await _googleSignInProvider.signInWithGoogle();
                      print("user ${user.toString()}");

                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Sign-In Successful: ${user.displayName}'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'LOG IN WITH GOOGLE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightColor.primaryColor,
                    ),
                    onPressed: () {
                      //initiateFacebookLogin();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.facebook,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'LOG IN WITH FACEBOOK',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _login(BuildContext context) {
    if (_signInKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      Provider.of<AppNotifier>(context,listen: false).setUserLogin(emailController.text,true);
      Navigator.pushReplacementNamed(context, Constants.dashboard);
    } else {
      scaffoldMessage(context, "Something went wrong..");
    }
  }

  dismissLoading() {
    print('Dismiss');
  }
}

void showLoading() {
  print('Start Fetching data from GOOGLE');
}

void onLoginStatusChanged(bool isLoggedIn) {
  print(isLoggedIn);
}

// void initiateFacebookLogin() async {
//   var facebookLogin = FacebookLogin();
//   var facebookLoginResult = await facebookLogin.logIn(['email']);
//   switch (facebookLoginResult.status) {
//     case FacebookLoginStatus.error:
//       print("Error");
//       onLoginStatusChanged(false);
//       break;
//     case FacebookLoginStatus.cancelledByUser:
//       print("CancelledByUser");
//       onLoginStatusChanged(false);
//       break;
//     case FacebookLoginStatus.loggedIn:
//       print("LoggedIn");
//
//       var profile = Network().getFBLoginData(facebookLoginResult);
//
//       print(profile.toString());
//
//       //onLoginStatusChanged(true, profileData: profile);
//       onLoginStatusChanged(true);
//
//       break;
//   }
