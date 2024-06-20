import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/pages/home_screen.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Fill the below fields to create new Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: firstnameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    icon: Icon(FontAwesomeIcons.userCircle),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lastnameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    icon: Icon(FontAwesomeIcons.users),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(FontAwesomeIcons.envelope),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: telephoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    icon: Icon(FontAwesomeIcons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    icon: Icon(FontAwesomeIcons.lock),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    icon: Icon(FontAwesomeIcons.lock),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: ButtonWidget(
                            text: 'Register',
                            onPressed: () => _register(context))),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: ButtonWidget(
                            text: 'Login',
                            color: LightColor.lightGrey,
                            onPressed: () => Navigator.pop(context)))
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  void _register(BuildContext context) {
    if (_signUpKey.currentState!.validate()) {
      // If the form is valid, navigate to the HomeScreen.
      Navigator.pushNamed(context, Constants.dashboard);
    } else {
      scaffoldMessage(context,"Something went wrong");
    }
  }

}
