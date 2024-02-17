import 'package:flutter/material.dart';

class CircileView extends StatelessWidget {
  final String image;
  final VoidCallback? voidCallback;
  const CircileView({Key? key, required this.image, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        voidCallback;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
      ),
    );
  }
}
