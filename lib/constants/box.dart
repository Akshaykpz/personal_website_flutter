import 'package:flutter/material.dart';
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
              color: AppColors.slate900,
              width: 1,
            )
          : null,
      color: AppColors.slateBlack,
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.slateBlack,
          AppColors.slate950,
          AppColors.slateBlack,
        ],
      ),
    );
  }

  static BoxDecoration surfaceDecoration({
    bool isHover = false,
    double radius = 8,
  }) {
    return BoxDecoration(
      color: isHover ? AppColors.opacity40 : AppColors.opacity56,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: isHover ? AppColors.turquoise300 : AppColors.slate900,
        width: 1,
      ),
      boxShadow: [
        if (isHover)
          BoxShadow(
            color: AppColors.turquoise300.withOpacity(0.18),
            blurRadius: 32,
            spreadRadius: -12,
          ),
      ],
    );
  }

  static BoxDecoration pillDecoration({bool isHover = false}) {
    return BoxDecoration(
      color: isHover ? AppColors.slate200 : AppColors.slateWhite,
      borderRadius: BorderRadius.circular(100),
      boxShadow: [
        BoxShadow(
          color: (isHover ? AppColors.pink300 : AppColors.turquoise300)
              .withOpacity(0.18),
          blurRadius: 28,
          spreadRadius: -8,
        ),
      ],
    );
  }

  static BoxDecoration ghostPillDecoration({bool isHover = false}) {
    return BoxDecoration(
      color: isHover ? AppColors.slate900 : AppColors.slate950,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: isHover ? AppColors.slate700 : AppColors.slate900,
        width: 1,
      ),
    );
  }
}
