import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';

class HelperClass extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final double paddingWidth;
  final Color bgColor;
  const HelperClass({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    required this.paddingWidth,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final horizontalPadding = isMobile ? 18.0 : paddingWidth;
        final verticalPadding = isMobile ? 40.0 : 64.0;
        final content = constraints.maxWidth < 768
            ? mobile
            : constraints.maxWidth < 1200
                ? tablet
                : desktop;

        return Container(
          width: size.width,
          alignment: Alignment.center,
          color: bgColor == Colors.transparent
              ? Colors.transparent
              : AppColors.slateBlack.withOpacity(0.68),
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1320,
              minHeight: 0,
            ),
            child: content,
          ),
        );
      },
    );
  }
}
