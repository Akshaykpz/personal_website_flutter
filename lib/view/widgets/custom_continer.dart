import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/textstyle.dart';

class CustomContainer extends StatelessWidget {
  final String image;
  final String text;

  const CustomContainer({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AnimatedContainer(
        height: 35,
        width: 160,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white38,
            ),
            borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image.asset(
            image,
            height: 20,
          ),
          Text(
            text,
            style: Apptext.aboutstyles1(),
          )
        ]),
      ),
    );
  }
}
