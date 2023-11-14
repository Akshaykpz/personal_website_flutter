import 'package:flutter/material.dart';

class CircileView extends StatelessWidget {
  final String image;
  const CircileView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: CircleAvatar(
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
