import 'package:book_reader/pages/app_sign_up.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final TextEditingController textEditingController;
  final IconData iconData;
  final TextInputType type;
  final bool readOnly;
  final VoidCallback? function;
  final FocusNode focusNode;
  final bool obscureText;

  const TextFieldWidget({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.iconData,
    this.type = TextInputType.text,
    this.errorText,
    this.readOnly = false,
    this.function,
    required this.focusNode,
    this.obscureText = false, // Default to false for normal text fields
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: function,
      readOnly: readOnly,
      focusNode: focusNode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Missing Required Field';
        }

        if (errorText != null) {
          return validateField(errorText!, textEditingController.text.trim());
        }

        return null;
      },
      keyboardType: type,
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: LightColor.black),
        prefixIcon: Icon(
          iconData,
          color: LightColor.black,
        ),
        border: getUnderLine(),
        enabledBorder: getUnderLine(),
        focusedBorder: getUnderLine(),
      ),
    );
  }

  UnderlineInputBorder getUnderLine() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black));
  }
}

String? validateField(String type, String data) {
  switch (type) {
    case 'Email':
      return validateEmail(data);
    case 'Password':
      return validatePassword(data);
    case 'Mobile Number':
      return validateMobile(data);
    case 'Confirm Password':
      return validateConfirmPassword(data);
    default:
      return validateName(data);
  }
}

String? validateName(String value) {
  Pattern pattern = '[a-zA-Z]';
  RegExp regex = RegExp(pattern.toString());
  return (!regex.hasMatch(value)) ? 'Invalid Name' : null;
}

String? validatePassword(String value) {
  if (!(value.length > 5) && value.isNotEmpty) {
    return "Password should contain more than 5 characters";
  }
  AppSignUp.password = value;
  return null;
}

String? validateConfirmPassword(String confirmPassword) {
  if (!(confirmPassword.length > 5) && confirmPassword.isNotEmpty) {
    return "Password should contain more than 5 characters";
  } else if (AppSignUp.password.isNotEmpty &&
      confirmPassword != AppSignUp.password) {
    return "Passwords do not match";
  }
  return null;
}

String? validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return (!regex.hasMatch(value)) ? 'Invalid Email Address' : null;
}

String? validateMobile(String value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    return 'Please Enter Mobile Number';
  } else if (!regExp.hasMatch(value)) {
    return 'Invalid Mobile Number';
  }
  return null;
}
