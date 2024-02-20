import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/textstyle.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        FadeInDown(
            child: RichText(
                text: TextSpan(
                    text: 'My',
                    style: Apptext.addstyles(Colors.white),
                    children: [
              TextSpan(
                text: '  Skills',
                style: Apptext.addstyles(Colors.blue),
              )
            ]))),
      ]),
    );
  }
}
