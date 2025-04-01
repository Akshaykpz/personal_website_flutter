import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_personal_website/constants/colors.dart';

class Constants {
  static SizedBox sizedBox({height, width}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}

class Colorss {
  static BoxDecoration gradientDecoration({bool withBorder = false}) {
    return BoxDecoration(
      border: withBorder
          ? Border.all(
              color: Colors.white,
              width: 0.1,
            )
          : null,
      gradient: const LinearGradient(colors: [
        AppColors.ebony,
        AppColors.studio,
      ]),
    );
  }
}
