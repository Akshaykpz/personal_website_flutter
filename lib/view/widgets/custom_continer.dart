import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_personal_website/constants/box.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/textstyle.dart';

class CustomContainer extends StatefulWidget {
  final String image;
  final String text;
  final TextStyle? style;
  const CustomContainer(
      {Key? key, required this.image, required this.text, this.style})
      : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        width: 168,
        height: 168,
        padding: const EdgeInsets.all(20),
        decoration: Colorss.surfaceDecoration(isHover: isHover),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, isHover ? -8.0 : 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedScale(
              scale: isHover ? 1.08 : 1,
              duration: const Duration(milliseconds: 260),
              child: Image.asset(
                widget.image,
                fit: BoxFit.contain,
                width: 78,
                height: 78,
                cacheWidth: 160,
                cacheHeight: 160,
              ),
            ),
            10.verticalSpace,
            Text(
              widget.text,
              style: widget.style ??
                  Apptext.aboutstyles1().copyWith(
                    color: isHover
                        ? AppColors.turquoise300
                        : AppColors.slateWhite,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
