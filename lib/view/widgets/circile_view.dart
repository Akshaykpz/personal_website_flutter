import 'package:flutter/material.dart';

class CircileView extends StatelessWidget {
  final String image;
  final VoidCallback? voidCallback;
  const CircileView({Key? key, required this.image, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white), shape: BoxShape.circle),
      child: InkWell(
        borderRadius: BorderRadius.circular(500),
        hoverColor: Colors.transparent,
        onTap: () {
          voidCallback;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Image.asset(
            image,
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }
}
