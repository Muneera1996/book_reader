import 'dart:convert';

import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/components/title_text.dart';
import 'package:book_reader/network/Network.dart';
import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/pages/app_sign_up.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/themes/theme.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _signInKey = GlobalKey<FormState>();
  AppSharedPreferences? sharedPreferences;
  Network network = Network();

  // Focus Nodes
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    AppSharedPreferences.getPreferencesInstance().then((value) {
      sharedPreferences = value;
      setState(() {
        emailController.text = sharedPreferences?.getEmail() ?? "";
      });
    });
    // Add focus listeners to clear errors
    addFocusListeners();
  }

  void addFocusListeners() {
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        _signInKey.currentState?.validate();
      }
    });
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        _signInKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    // Dispose FocusNodes
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
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
                  errorText: 'Email',
                  focusNode: emailFocusNode,
                ),
                TextFieldWidget(
                  type: TextInputType.visiblePassword,
                  textEditingController: passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  iconData: FontAwesomeIcons.userLock,
                  errorText: 'Password',
                  focusNode: passwordFocusNode,
                ),
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
                            builder: (context) => const AppSignUp(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: TitleText(
                    text: "OR",
                    color: LightColor.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: _handleGoogleSignIn,
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
                    // initiateFacebookLogin();
                  },
                  icon: const Icon(
                    FontAwesomeIcons.facebook,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'LOG IN WITH FACEBOOK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      showLoading();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        dismissLoading();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      scaffoldMessage(context, "Credential: $credential");

      // await FirebaseAuth.instance.signInWithCredential(credential);
      // onLoginStatusChanged(true);

      // Save the user's email to shared preferences
      // if (sharedPreferences != null) {
      //   sharedPreferences?.setEmail(googleUser.email);
      // }

      // Navigator.pushReplacementNamed(context, Constants.dashboard);
    } catch (error) {
      print("error $error");
      dismissLoading();
      scaffoldMessage(context, "Something went wrong with Google sign-in.");
    }
  }

  void _login(BuildContext context) async {
    if (_signInKey.currentState!.validate()) {
      showLoading();
      try {
        final email = emailController.text;
        final password = passwordController.text;

        final response = await network.signIn(email, password);
        final token = response['data']['token'];

        // Save data and Navigate to the dashboard
        Provider.of<AppNotifier>(context, listen: false).setUserLogin(token,email, true);
        Navigator.pushReplacementNamed(context, Constants.dashboard);
      } catch (error) {
        dismissLoading();
        scaffoldMessage(
            context, "Invalid email or password. Please try again.");
      }
    } else {
      scaffoldMessage(context, "Please fill in all fields.");
    }
  }

  void showLoading() {
    print('Start Fetching data from GOOGLE');
  }

  void dismissLoading() {
    print('Dismiss');
  }

  void scaffoldMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
