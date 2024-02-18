import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';

class MyService extends StatelessWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Column(children: [
        FadeInDown(
            child: RichText(
                text: TextSpan(
                    text: 'My',
                    style: Apptext.addstyles(Colors.white),
                    children: [
              TextSpan(
                text: '  Services',
                style: Apptext.addstyles(Colors.blue),
              )
            ]))),
        Row(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2),
              child: Column(
                children: [
                  Image.asset(AppImage.flutter),
                  const Text('App Development'),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}
