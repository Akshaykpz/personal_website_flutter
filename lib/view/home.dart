import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/view/widgets/about.dart';
import 'package:my_personal_website/view/widgets/circile_view.dart';
import 'package:my_personal_website/view/widgets/contact_us.dart';
import 'package:my_personal_website/view/widgets/footer_class.dart';
import 'package:my_personal_website/view/widgets/my_portfolio.dart';
import 'package:my_personal_website/view/widgets/my_service.dart';
import 'package:my_personal_website/view/widgets/profile_image.dart';
import 'dart:html' as html;

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Color backgroundColor = Color.fromARGB(255, 13, 16, 28);
  final Color buttonColor = Colors.blue;
  bool isHover = false;
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
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(children: [
            Text(
              'Portfolio',
              style: Apptext.headertextstyle(),
            ),
            const Spacer(),
            Text(
              'Home',
              style: Apptext.headertextstyle(),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'About',
              style: Apptext.headertextstyle(),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Service',
              style: Apptext.headertextstyle(),
            ),
            const SizedBox(
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
        // padding: const EdgeInsets.only(top: 30, left: 150, right: 20),
        child: Column(children: [
          const SizedBox(
            height: 100,
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
                        AnimatedTextKit(animatedTexts: [
                          TyperAnimatedText("Flutter Developer ",
                              textStyle: Apptext.textestyles())
                        ]),
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
              // Image.asset(
              //   AppImage.image,
              //   height: 100,
              //   fit: BoxFit.cover,
              // )
              const ProfileImage(),
              const SizedBox(
                width: 80,
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
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
          const MyService(),
          const MyPortfolio(),
          const ContactMe(),
          const FotterClass(),
        ]),
      ),
    );
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = "Akshay kp resume";
    anchorElement.click();
  }
}
