import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/colors.dart';
import 'package:my_personal_website/textstyle.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolors,
      appBar: AppBar(
        titleSpacing: 20,
        toolbarHeight: 90,
        backgroundColor: AppColors.bgcolors,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(children: [
            Text(
              'Portfolio',
              style: Apptext.headertextstyle(),
            ),
            Spacer(),
            Text(
              'Home',
              style: Apptext.headertextstyle(),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'About',
              style: Apptext.headertextstyle(),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Service',
              style: Apptext.headertextstyle(),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Contact',
              style: Apptext.headertextstyle(),
            )
          ]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 30, left: 150, right: 20),
        child: Column(children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Hello It's Me",
                    style: Apptext.biodatas(),
                  ),
                  Text(
                    "AKSHAY KP",
                    style: Apptext.addstyles(),
                  ),
                  // AnimatedTextKit(animatedTexts: [
                  //   TyperAnimatedText("And I'm a",
                  //       textStyle: Apptext.textestyles())
                  // ]),
                  Row(
                    children: [
                      AnimatedTextKit(animatedTexts: [
                        TyperAnimatedText("And I'm a ",
                            textStyle: Apptext.headertextstyle())
                      ]),
                      AnimatedTextKit(animatedTexts: [
                        TyperAnimatedText("Flutter Developer",
                            textStyle: Apptext.textestyles())
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hey there! a passionate Flutter developer with a knack for turning\n"
                    "innovative ideas into seamless, visually appealing, and highly functional\n"
                    "mobile applications. With a solid background in mobile app development....",
                    style: Apptext.aboutstyles(),
                  )
                  // SizedBox(
                  //   width: MediaQuery.sizeOf(context).width * 3,
                  //   child: Text(
                  //       "Hey there! a passionate Flutter developer with a knack for turning"
                  //       "innovative ideas into seamless, visually appealing, and highly functional"
                  //       "mobile applications. With a solid background in mobile app development and a deep understanding of the Flutter framework,"
                  //       "I'm dedicated to creating user-centric experiences that captivate and delight users"),
                  // )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
