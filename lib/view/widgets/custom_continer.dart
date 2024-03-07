import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String image;
  final String text;
  final TextStyle? style;
  const CustomContainer(
      {Key? key, required this.image, required this.text, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.1 * 1.3,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white38,
          ),
          borderRadius: BorderRadius.circular(10)),
      duration: const Duration(milliseconds: 100),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Image.asset(
            image,
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.01,
          ),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.01,
              color: Colors.white),
        ),
      ]),
    );
  }
}
