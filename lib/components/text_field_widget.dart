import 'package:book_reader/pages/app_sign_up.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final String errorText;
  final TextEditingController textEditingController;
  final IconData iconData;
  final TextInputType type;
  final bool readOnly;

  const TextFieldWidget({super.key,
    required this.textEditingController,
    required this.labelText,
    required this.iconData,
    this.type = TextInputType.text,
    this.errorText = 'Text',
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: readOnly,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Missing Required Field';
          }

          return validateField(errorText, textEditingController.text.trim());
        },
        keyboardType: type,
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: LightColor.secondaryDarkColor),
          prefixIcon: Icon(
            iconData,
            color: LightColor.secondaryDarkColor,
          ),
          border: getUnderLine(),
          enabledBorder: getUnderLine(),
          focusedBorder: getUnderLine(),
        ));
  }

  UnderlineInputBorder getGreenUnderLine() {
    return const UnderlineInputBorder(
        // borderRadius: BorderRadius.all(),
        borderSide: BorderSide(color: Colors.green));
  }

  UnderlineInputBorder getUnderLine() {
    return const UnderlineInputBorder(
        // borderRadius: BorderRadius.all(),
        borderSide: BorderSide(color: Colors.black));
  }
}

String? validateField(String type, String data) {
  switch (type) {
    case 'Email':
      return validateEmail(data);
      break;
    case 'Password':
      return validatePassword(data);
      break;
    case 'Number':
      return validateMobile(data);
      break;
    case 'Confirm Password':
      return validateConfirmPassword(data);
      break;
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
    return "Password should contains more then 5 character";
  }
  AppSignUp.password = value;
  return null;
}

String? validateConfirmPassword(String confirmPassword) {
  //print('$confirmPassword $password');
  if (!(confirmPassword.length > 5) && confirmPassword.isNotEmpty) {
    return "Password should contains more then 5 character";
  } else if (AppSignUp.password.isNotEmpty &&
      confirmPassword != AppSignUp.password) {
    return "Password Does not Match";
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
