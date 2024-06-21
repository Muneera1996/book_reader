import 'package:flutter/material.dart';
import 'package:book_reader/themes/light_color.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;

  const TitleText({
    Key? key,
    required this.text,
    this.fontSize = 17,
    this.color = LightColor.black,
    this.fontWeight = FontWeight.w800,
    this.textAlign = TextAlign.center,
    this.overflow = TextOverflow.clip,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
