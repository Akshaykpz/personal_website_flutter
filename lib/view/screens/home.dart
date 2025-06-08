import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/animations.dart';
import 'package:my_personal_website/constants/colors.dart';

import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';

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
          const Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              MvNeuralWeb(),
            ],
          ),
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(flex: 1, child: BuildHomemethod(size)),
          const Stack(
            alignment: Alignment.center,
            children: [
              MvNeuralWeb(),
              // Lottie.asset('assets/images/Animation - 1709290147936.json',
              //     height: 540),
              // const ProfileImage(),
            ],
          ),
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: BuildHomemethod(size)),
          const Stack(
            alignment: Alignment.topCenter,
            children: [
              MvNeuralWeb(),
              // Lottie.asset('assets/images/Animation - 1709290147936.json',
              //     height: 500),
              // const ProfileImage(),
            ],
          ),
        ],
      ),
    );
  }

  SlideInDown BuildHomemethod(Size size) {
    return SlideInDown(
      duration: const Duration(seconds: 1),
      child: Column(
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
          const SizedBox(height: 5),
          SizedBox(
            height: 110,
            child: FadeInLeft(
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "And I'm a Flutter Developer",
                    textStyle: Apptext.headertextstyle1(),
                    speed: const Duration(milliseconds: 80),
                  ),
                ],
                totalRepeatCount: 999,
                pause: const Duration(milliseconds: 2000),
                displayFullTextOnTap: true,
                repeatForever: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInDown(
            child: Text(
              "Hey there! a passionate Flutter developer with a knack for turning\n"
              "innovative ideas into seamless, visually appealing, and highly functional\n"
              "mobile applications. With a solid background in mobile app development....",
              style: Apptext.aboutstyles(),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = "Akshay kp resume";
    anchorElement.click();
  }
}
