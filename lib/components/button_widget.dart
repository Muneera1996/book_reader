import 'package:flutter/material.dart';

import '../themes/light_color.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double fontSize;

  const ButtonWidget({super.key,
    required this.text,
    required this.onPressed,
    this.color = LightColor.primaryColor,
    this.fontSize = 17,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
            color: color == (LightColor.lightGrey) ? Colors.black : Colors.white
        ),
      ),
    );
  }
}
