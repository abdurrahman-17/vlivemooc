import 'package:flutter/material.dart';
TextStyle poppinsLight(double fontSize, Color color) => TextStyle(
      fontSize: fontSize,
      color: color,
      fontFamily: "Poppins-Regular",
    );

TextStyle poppinsLightWithHight(double fontSize, Color color,
        {required double spacingHeight}) =>
    TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: "Poppins-Regular",
        height: spacingHeight);

TextStyle poppinsMediumWithHeight(double fontSize, Color color,
        {required double spacingHeight}) =>
    TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins-Regular",
        height: spacingHeight);

TextStyle poppinsBold(double fontSize, Color color){

  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.w900,
    fontFamily: "Poppins-Regular",
  );
}

TextStyle poppinsMedium(double fontSize, Color color) => TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins-Regular",
    );

