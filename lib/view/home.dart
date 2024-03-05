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
    return Scaffold(
      // backgroundColor: AppColors.bgcolors,
      // appBar: AppBar(
      //   titleSpacing: 100,
      //   toolbarHeight: 90,
      //   backgroundColor: AppColors.bgcolors,
      //   elevation: 0,
      //   title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      //     Text(
      //       'Portfolio',
      //       style: Apptext.biodatas(),
      //     ),
      //     const Spacer(),
      //     SizedBox(
      //       height: 40,
      //       child: ListView.separated(
      //           shrinkWrap: true,
      //           scrollDirection: Axis.horizontal,
      //           itemBuilder: (context, index) => const SizedBox(
      //                 width: 3,
      //               ),
      //           separatorBuilder: (context, index) {
      //             return InkWell(
      //               onTap: () {},
      //               borderRadius: BorderRadius.circular(100),
      //               onHover: (value) {
      //                 setState(() {
      //                   if (value) {
      //                     menuIndex = index;
      //                   } else {
      //                     menuIndex = 0;
      //                   }
      //                 });
      //               },
      //               child: animatedContainer(
      //                   index, menuIndex == index ? true : false),
      //             );
      //           },
      //           itemCount: menuitem.length),
      //     ),
      //   ]),
      // ),
      body: Container(
          color: AppColors.bgcolors,
          height: size.height,
          width: size.width,
          padding:
              EdgeInsets.symmetric(vertical: 30, horizontal: size.width * 0.1),
          child: HelperClass(
            mobile: Column(
              children: [
                BuildHomemethod(),
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
            tablet: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: BuildHomemethod()),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Lottie.asset(
                          'assets/images/Animation - 1709290147936.json',
                          height: 540),
                      const ProfileImage(),
                    ],
                  ),
                ),
              ],
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BuildHomemethod(),
                Stack(
                  children: [
                    Lottie.asset('assets/images/Animation - 1709290147936.json',
                        height: 540),
                    const ProfileImage(),
                  ],
                ),
              ],
            ),
          )),

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
      //         InkWell(
      //           onTap: () {
      //             downloadFile('assets/images/Akshay KP.resume.pdf');
      //           },
      //           onHover: (value) {
      //             setState(() {
      //               isHover = value;
      //             });
      //           },
      //           child: Container(
      //             height: 50,
      //             width: 200,
      //             decoration: isHover
      //                 ? BoxDecoration(
      //                     borderRadius: BorderRadius.circular(25),
      //                     boxShadow: const [
      //                       BoxShadow(
      //                           offset: Offset(0.0, 0.0),
      //                           blurRadius: 20,
      //                           color: Colors.white),
      //                     ],
      //                     gradient: const LinearGradient(
      //                       begin: Alignment.centerLeft,
      //                       end: Alignment.centerRight,
      //                       colors: [
      //                         Colors.blue,
      //                         Colors.purple,
      //                       ],
      //                     ))
      //                 : BoxDecoration(
      //                     borderRadius: BorderRadius.circular(25),
      //                     boxShadow: const [
      //                       BoxShadow(
      //                           offset: Offset(0.0, 0.0),
      //                           blurRadius: 3,
      //                           color: Colors.transparent),
      //                     ],
      //                     gradient: const LinearGradient(
      //                       begin: Alignment.centerLeft,
      //                       end: Alignment.centerRight,
      //                       colors: [
      //                         Colors.blue,
      //                         Colors.purple,
      //                       ],
      //                     )),
      //             child: Center(
      //                 child: Text(
      //               'Check Resume',
      //               style: TextStyle(
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.w600,
      //                   color: isHover ? Colors.white : Colors.white),
      //             )),
      //           ),
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
      //     const Expierence(),

      //     const MyPortfolio(),
      //     const ContactMe(),
      //     const FotterClass(),
      //   ]),
      // ),
    );
  }

  // ignore: non_constant_identifier_names
  Column BuildHomemethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
            direction: Axis.horizontal,
            children: [
              AnimatedTextKit(animatedTexts: [
                TyperAnimatedText("And I'm a ",
                    textStyle: Apptext.headertextstyle1())
              ]),
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
            "innovative ideas into seamless, visually appealing, and highly functional\n "
            "mobile applications. With a solid background in mobile app development....",
            style: Apptext.aboutstyles(),
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
