import 'package:flutter/material.dart';

class AppTextStyles {
  static const String _fontFamily = 'OpenSans';

  static TextStyle regular(double size) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: size,
    );
  }

  static TextStyle medium(double size) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: size,
    );
  }

  static TextStyle bold(double size) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: size,
    );
  }

  static TextStyle italic(double size) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontStyle: FontStyle.italic,
      fontSize: size,
    );
  }

  static TextStyle boldItalic(double size) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      fontSize: size,
    );
  }
}
