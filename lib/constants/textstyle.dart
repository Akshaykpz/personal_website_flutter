import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Apptext {
  static TextStyle headertextstyle(Color color) {
    return GoogleFonts.mukta(
        fontSize: 17.5, fontWeight: FontWeight.w600, color: color);
  }

  static TextStyle headertextstyle1([double? fontsize]) {
    return GoogleFonts.mukta(
        fontSize: fontsize ?? 40,
        fontWeight: FontWeight.w900,
        color: Colors.white);
  }

  static TextStyle biodatas() {
    return GoogleFonts.mukta(
        fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  }

  static TextStyle textestyles() {
    return GoogleFonts.mukta(
        fontSize: 40, fontWeight: FontWeight.w600, color: Colors.blueAccent);
  }

  static TextStyle addstyles([Color? color, double? fontsize]) {
    return GoogleFonts.rubikMoonrocks(
        letterSpacing: 2,
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: color);
  }

  static TextStyle addstyles1([Color? color]) {
    return GoogleFonts.rubikMoonrocks(
        letterSpacing: 2,
        fontSize: 55,
        fontWeight: FontWeight.w400,
        color: color);
  }

  static TextStyle aboutstyles() {
    return GoogleFonts.abel(
        letterSpacing: 2,
        fontSize: 17,
        fontWeight: FontWeight.w300,
        color: Colors.white);
  }

  static TextStyle aboutstyles1([double? fontsizes]) {
    return GoogleFonts.abel(
        letterSpacing: 2,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white);
  }

  static TextStyle aboutstyles2() {
    return GoogleFonts.abel(
        letterSpacing: 2,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white70);
  }
}
