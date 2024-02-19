import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';

class FotterClass extends StatelessWidget {
  const FotterClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        color: AppColors.bgcolors1,
      ),
    );
  }
}
