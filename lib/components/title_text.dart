import 'package:book_reader/themes/light_color.dart';
import 'package:flutter/material.dart';


class TitleText extends StatelessWidget {

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const TitleText({super.key,
    required this.text,
    this.fontSize = 17,
    this.color = LightColor.black,
    this.fontWeight = FontWeight.w800, this.textAlign = TextAlign.center
  });


  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}

