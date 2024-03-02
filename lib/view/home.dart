import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/text.dart';

import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/view/widgets/about.dart';

import 'package:my_personal_website/view/widgets/contact_us.dart';
import 'package:my_personal_website/view/widgets/experience.dart';
import 'package:my_personal_website/view/widgets/footer_class.dart';
import 'package:my_personal_website/view/widgets/my_portfolio.dart';
import 'package:my_personal_website/view/widgets/my_service.dart';
import 'package:my_personal_website/view/widgets/profile_image.dart';
import 'dart:html' as html;

import 'package:my_personal_website/view/widgets/topbar_content.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final onmenuHover = Matrix4.identity()..scale(1.0);
  final menuitem = <String>[
    'About',
    'Skills',
    'Experience',
    'Service',
    'Projects',
    'Projects',
  ];
  final Color backgroundColor = Color.fromARGB(255, 13, 16, 28);
  final Color buttonColor = Colors.blue;
  var menuIndex = 0;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolors,
      appBar: AppBar(
        titleSpacing: 100,
        toolbarHeight: 90,
        backgroundColor: AppColors.bgcolors,
        elevation: 0,
        title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'Portfolio',
            style: Apptext.biodatas(),
          ),
          const Spacer(),
          SizedBox(
            height: 40,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => const SizedBox(
                      width: 3,
                    ),
                separatorBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100),
                    onHover: (value) {
                      setState(() {
                        if (value) {
                          menuIndex = index;
                        } else {
                          menuIndex = 0;
                        }
                      });
                    },
                    child: animatedContainer(
                        index, menuIndex == index ? true : false),
                  );
                },
                itemCount: menuitem.length),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
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
                    child: Row(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FadeInDown(
                        child: Text(
                          "Hey there! a passionate Flutter developer with a knack for turning\n"
                          "innovative ideas into seamless, visually appealing, and highly functional\n"
                          "mobile applications. With a solid background in mobile app development....",
                          style: Apptext.aboutstyles(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.asset('assets/images/Animation - 1709290147936.json',
                      height: 540),

                  // Image.asset(
                  //   'assets/images/Animation - 1709289052606.gif',
                  //   height: 100,
                  // ),

                  const ProfileImage(),
                ],
              ),
              // Image.asset(
              //   AppImage.image,
              //   height: 100,
              //   fit: BoxFit.cover,
              // )
            ],
          ),
          // const SizedBox(
          //   height: 50,
          // ),
          Row(
            children: [
              const SizedBox(
                width: 300,
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
                                blurRadius: 20,
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
          ),
          const SizedBox(
            height: 150,
          ),
          const AboutMe(),
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
            height: 150,
          ),
          const Expierence(),
          const MyService(),
          const MyPortfolio(),
          const ContactMe(),
          const FotterClass(),
        ]),
      ),
    );
  }

  AnimatedContainer animatedContainer(int index, bool hover) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.center,
      width: hover ? 90 : 85,
      transform: hover ? onmenuHover : null,
      child: Text(menuitem[index],
          style: Apptext.headertextstyle(hover ? Colors.blue : Colors.white)),
    );
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = "Akshay kp resume";
    anchorElement.click();
  }
}
