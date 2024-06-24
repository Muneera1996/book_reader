import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/components/text_field_widget.dart';
import 'package:book_reader/network/Network.dart';
import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/pages/home_screen.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AppSignUp extends StatefulWidget {
  const AppSignUp({super.key});

  @override
  State<AppSignUp> createState() => _AppSignUpState();

  static String password = " ";
}

class _AppSignUpState extends State<AppSignUp> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  final _signUpKey = GlobalKey<FormState>();

  // Define FocusNodes for each TextFormField
  final FocusNode _firstnameFocus = FocusNode();
  final FocusNode _lastnameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _telephoneFocus = FocusNode();
  Network network = Network();

  @override
  void dispose() {
    // Dispose FocusNodes to avoid memory leaks
    _firstnameFocus.dispose();
    _lastnameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _telephoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Form(
        key: _signUpKey,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 10),
              const Text(
                'Fill the below fields to create new Account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                textEditingController: firstnameController,
                labelText: 'First Name',
                iconData: FontAwesomeIcons.userCircle,
                errorText: 'Please enter your first name',
                focusNode: _firstnameFocus,
              ),
              TextFieldWidget(
                textEditingController: lastnameController,
                labelText: 'Last Name',
                iconData: FontAwesomeIcons.users,
                errorText: 'Please enter your last name',
                focusNode: _lastnameFocus,
              ),
              TextFieldWidget(
                textEditingController: emailController,
                labelText: 'Email',
                iconData: FontAwesomeIcons.envelope,
                type: TextInputType.emailAddress,
                errorText: 'Email',
                focusNode: _emailFocus,
              ),
              TextFieldWidget(
                textEditingController: telephoneController,
                labelText: 'Mobile Number',
                iconData: FontAwesomeIcons.phone,
                type: TextInputType.phone,
                errorText: 'Mobile Number',
                focusNode: _telephoneFocus,
              ),
              TextFieldWidget(
                textEditingController: passwordController,
                labelText: 'Password',
                iconData: FontAwesomeIcons.lock,
                obscureText: true,
                errorText: 'Password',
                focusNode: _passwordFocus,
              ),
              TextFieldWidget(
                textEditingController: confirmPasswordController,
                labelText: 'Confirm Password',
                iconData: FontAwesomeIcons.lock,
                obscureText: true,
                errorText: 'Confirm Password',
                focusNode: _confirmPasswordFocus,
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonWidget(
                      text: 'Register',
                      onPressed: () => _register(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ButtonWidget(
                      text: 'Login',
                      color: LightColor.lightGrey,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register(BuildContext context) {
    if (_signUpKey.currentState!.validate()) {
      // If the form is valid, api success, navigate to the HomeScreen.
      signUpUser();

    } else {
      scaffoldMessage(context, "Please fill in all fields..");

    }
  }

  void signUpUser() async {
   // showLoading();
    try {
      final email = emailController.text;
      final password = passwordController.text;
      final firstname = firstnameController.text;
      final lastname = lastnameController.text;
      final mobile = telephoneController.text;

      final response = await network.signUp(email, password, firstname, lastname, mobile);

      // Assuming the response contains user data and token
      if(response!=null&&response.isNotEmpty) {
        final token = response['data']['token'];
        // Navigate to the dashboard
        Provider.of<AppNotifier>(context, listen: false).setUserLogin(
            token, email, true);
        Navigator.pushReplacementNamed(context, Constants.dashboard);
      }
    } catch (error) {
  //  dismissLoading();
    scaffoldMessage(context, "Error $error");
    }
  }
}
