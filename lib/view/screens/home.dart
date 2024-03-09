import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/text.dart';

import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';

import 'package:my_personal_website/view/widgets/profile_image.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Homepage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Color backgroundColor = const Color.fromARGB(255, 13, 16, 28);
  final Color buttonColor = Colors.blue;

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      paddingWidth: size.width * 0.1,
      bgColor: AppColors.bgcolors,
      mobile: Column(
        children: [
          BuildHomemethod(size),
          Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset('assets/images/Animation - 1709290147936.json',
                  height: 560),
              const ProfileImage(),
            ],
          ),
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(flex: 1, child: BuildHomemethod(size)),
          Stack(
            alignment: Alignment.center,
            children: [
              Lottie.asset('assets/images/Animation - 1709290147936.json',
                  height: 540),
              const ProfileImage(),
            ],
          ),
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: BuildHomemethod(size)),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Lottie.asset('assets/images/Animation - 1709290147936.json',
                  height: 540),
              const ProfileImage(),
            ],
          ),
        ],
      ),
    );

    // SingleChildScrollView(
    //   child: Column(children: [
    //     const SizedBox(
    //       height: 10,
    //     ),

    //     // const SizedBox(
    //     //   height: 50,
    //     // ),
    //     Row(
    //       children: [
    //         const SizedBox(
    //           width: 300,
    //         ),

    //       ],
    //     ),
    //     const SizedBox(
    //       height: 150,
    //     ),
    //     const AboutMe(),
    //     const SizedBox(
    //       height: 50,
    //     ),
    //     const SizedBox(
    //       height: 150,
    //     ),

    //   ]),
    // ),
  }

  // ignore: non_constant_identifier_names
  Column BuildHomemethod(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FadeInDown(
          child: Text(
            "Hello It's Me",
            style: Apptext.headertextstyle1(),
          ),
        ),
        FadeInDown(
          child: Text(
            "AKSHAY KP",
            style: Apptext.addstyles1(Colors.white),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        FadeInLeft(
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            direction: Axis.horizontal,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "And I'm a ",
                    textStyle: Apptext.headertextstyle1(),
                  ),
                ],
                pause: const Duration(milliseconds: 2000),
                displayFullTextOnTap: true,
                isRepeatingAnimation: true,
                repeatForever: true,
                // stopPauseOnTap: true,
              ),
              GradientText(
                text: "Flutter Developer",
                gradient: const LinearGradient(colors: [
                  Colors.blue,
                  Colors.purple,
                ]),
                style: GoogleFonts.mukta(
                    fontSize: 40, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FadeInDown(
          child: Text(
            "Hey there! a passionate Flutter developer with a knack for turning\n"
            "innovative ideas into seamless, visually appealing, and highly functional\n"
            "mobile applications. With a solid background in mobile app development....",
            style: Apptext.aboutstyles(),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        InkWell(
          onTap: () {
            downloadFile('assets/images/Akshay KP.resume.pdf');
          },
          onHover: (value) {
            setState(() {
              isHover = value;
            });
          },
          child: Container(
            height: 50,
            width: 200,
            decoration: isHover
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10,
                          color: Colors.white),
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.blue,
                        Colors.purple,
                      ],
                    ))
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 3,
                          color: Colors.transparent),
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.blue,
                        Colors.purple,
                      ],
                    )),
            child: Center(
                child: Text(
              'Check Resume',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isHover ? Colors.white : Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = "Akshay kp resume";
    anchorElement.click();
  }
}
