import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/view/widgets/circile_view.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

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
        padding: const EdgeInsets.only(top: 30, left: 150, right: 20),
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Hello It's Me",
                    style: Apptext.headertextstyle(),
                  ),
                  Text(
                    "AKSHAY KP",
                    style: Apptext.addstyles(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Hey there! a passionate Flutter developer with a knack for turning\n"
                        "innovative ideas into seamless, visually appealing, and highly functional\n"
                        "mobile applications. With a solid background in mobile app development....",
                        style: Apptext.aboutstyles(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircileView(image: AppImage.oneimage),
                      CircileView(image: AppImage.hello),
                      CircileView(image: AppImage.instagram),
                      CircileView(image: AppImage.twitter),
                    ],
                  )
                ],
              ),
              // Image.asset(
              //   AppImage.image,
              //   height: 100,
              //   fit: BoxFit.cover,
              // )
              CircleAvatar(
                maxRadius: 105,
                backgroundColor: Colors.white30,

                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipOval(
                      child: SizedBox.fromSize(
                    size: const Size.fromRadius(
                      104.6,
                    ),
                    child: Image.asset(
                      AppImage.image,
                      fit: BoxFit.cover,
                    ),
                  )),
                ),
                // backgroundImage: AssetImage(
                //   AppImage.image,
                // ),
              ),
              const SizedBox(
                width: 80,
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                isHover = value;
              });
            },
            child: Container(
              height: 60,
              width: 200,
              decoration: isHover
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: buttonColor,
                      boxShadow: [
                          BoxShadow(color: buttonColor, blurRadius: 10),
                          BoxShadow(color: buttonColor, blurRadius: 20),
                          BoxShadow(color: buttonColor, blurRadius: 40),
                        ])
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
              child: const Center(
                  child: Text(
                'Download My CV',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )),
            ),
          )
        ]),
      ),
    );
  }
}
