import 'package:flutter/material.dart';


class CustomTextStyle {
  static TextStyle customStyle(
      String fontFamily, Color color, double size, FontWeight fontWeight) {
    return TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontSize: size,
        fontWeight: fontWeight);
  }


  TextStyle customFont(double size, {Color color = Colors.black, FontWeight weight = FontWeight.normal}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }

}