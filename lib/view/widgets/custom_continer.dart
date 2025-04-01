import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final String image;
  final String text;
  final TextStyle? style;
  const CustomContainer(
      {Key? key, required this.image, required this.text, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: AnimatedContainer(
        // height: 100,
        // width: MediaQuery.of(context).size.width * 0.1 * 1.9,
        decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.white38,
            // ),
            borderRadius: BorderRadius.circular(5)),
        duration: const Duration(milliseconds: 100),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset(
            image,
            fit: BoxFit.contain,
            width: 100,
            height: 100,
          ),
          10.verticalSpace,
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
