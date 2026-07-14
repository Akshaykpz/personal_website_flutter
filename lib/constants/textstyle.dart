import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_personal_website/constants/colors.dart';

class Apptext {
  static TextStyle headertextstyle(Color color) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: color,
      height: 1.4,
    );
  }

  static TextStyle headertextstyle1([double? fontsize]) {
    return GoogleFonts.inter(
      fontSize: fontsize ?? 56,
      fontWeight: FontWeight.w200,
      color: AppColors.slateWhite,
      height: 1.14,
    );
  }

  static TextStyle biodatas() {
    return GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: AppColors.slateWhite,
      height: 1,
    );
  }

  static TextStyle textestyles() {
    return GoogleFonts.inter(
      fontSize: 40,
      fontWeight: FontWeight.w300,
      color: AppColors.turquoise300,
      height: 1.18,
    );
  }

  static TextStyle addstyles([Color? color, double? fontsize]) {
    return GoogleFonts.inter(
      fontSize: fontsize ?? 40,
      fontWeight: FontWeight.w200,
      color: color ?? AppColors.slateWhite,
      height: 1.14,
    );
  }

  static TextStyle addstyles1([Color? color]) {
    return GoogleFonts.inter(
      fontSize: 56,
      fontWeight: FontWeight.w200,
      color: color ?? AppColors.slateWhite,
      height: 1.14,
    );
  }

  static TextStyle aboutstyles() {
    return GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w200,
      color: AppColors.slate200,
      height: 1.5,
    );
  }

  static TextStyle aboutstyles1([double? fontsizes]) {
    return GoogleFonts.inter(
      fontSize: fontsizes ?? 16,
      fontWeight: FontWeight.w400,
      color: AppColors.slateWhite,
      height: 1.45,
    );
  }

  static TextStyle aboutstyles2() {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: AppColors.slate400,
      height: 1.5,
    );
  }

  static TextStyle monoLabel([Color? color]) {
    return GoogleFonts.ibmPlexMono(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.slate400,
      height: 1.7,
    );
  }

  static TextStyle buttonText([Color? color]) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.slateBlack,
      height: 1.65,
    );
  }
}
