import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Apptext {
  static TextStyle headertextstyle() {
    return GoogleFonts.mukta(
        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white);
  }

  static TextStyle biodatas() {
    return GoogleFonts.mukta(
        fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  }

  static TextStyle textestyles() {
    return GoogleFonts.mukta(
        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueAccent);
  }

  static TextStyle addstyles() {
    return GoogleFonts.rubikMoonrocks(
        letterSpacing: 2,
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: Colors.white);
  }

  static TextStyle aboutstyles() {
    return GoogleFonts.abel(
        letterSpacing: 2,
        fontSize: 15,
        fontWeight: FontWeight.w100,
        color: Colors.white);
  }
}
