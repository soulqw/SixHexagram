import 'package:flutter/material.dart';

class Commons {
  static int DEFAULT_GRAY = 0xFF999999;

  static int DEFAULT_GRAY_2 = 0xFFDDDDDD;

  static int DEFAULT_GRAY_3 = 0xFFBFC3CC;

  static int DEFAULT_BLUE = 0xFF2f81FC;

  static int DEFAULT_BLUE_2 = 0xFF97C0FD;

  static int DEFAULT_RED_1 = 0xFFF56C6C;

  static int TIMER_COUNT = 60;

  static InputDecoration getEditInputDecoration(
      EdgeInsetsGeometry contentPadding, String hintText, TextStyle hintStyle) {
    return InputDecoration(
      contentPadding: contentPadding,
      hintText: hintText,
      hintStyle: hintStyle,
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(Commons.DEFAULT_GRAY_2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(Commons.DEFAULT_BLUE))),
    );
  }

  static bool isNotEmpty(String origin) {
    return origin != null && origin.length > 0;
  }

  static Widget getClearButton(GestureTapCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.cancel,
        color: Color(Commons.DEFAULT_GRAY_3),
      ),
    );
  }
}
