import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';
import 'package:my_personal_website/view/widgets/custom_continer.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        height: size.height * 0.7,
        width: size.width * 0.6,

        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(15),
          color: Colors.black12,
          border: Border.all(
            style: BorderStyle.solid,
            width: 1,
            color: Colors.white24,
          ),
        ),
        // height: 400,
        // width: MediaQuery.of(context).size.width * 0.8,
        child: HelperClass(
          paddingWidth: size.width * 0.1,
          bgColor: AppColors.bgcolors,
          desktop: Row(children: [skillsColum()]),
          mobile: Column(children: [skillsColum()]),
          tablet: Row(children: [skillsColum()]),
        ),
      ),
    );
  }

  Column skillsColum() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      FadeInDown(
          child: RichText(
              text: TextSpan(
                  text: 'My',
                  style: Apptext.addstyles(Colors.white),
                  children: [
            TextSpan(
              text: '  Skills',
              style: Apptext.addstyles(Colors.white),
            )
          ]))),
      const SizedBox(
        height: 30,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomContainer(image: 'assets/images/dart.png', text: 'Dart'),
          CustomContainer(image: 'assets/images/flutter.png', text: 'Flutter'),
          CustomContainer(image: 'assets/images/github.png', text: 'Git Hub'),
          CustomContainer(
              image:
                  'assets/images/WhatsApp Image 2024-02-25 at 16.43.26_966c41bb.jpg',
              text: 'Hive'),
        ],
      ),
      const SizedBox(
        height: 30,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomContainer(image: 'assets/images/figma.png', text: 'Figma'),
          CustomContainer(
              image:
                  'assets/images/WhatsApp Image 2024-02-25 at 16.46.58_f54a21e3.jpg',
              text: 'Getx'),
          CustomContainer(
              image:
                  'assets/images/WhatsApp Image 2024-02-25 at 16.48.07_355e3ce5.jpg',
              text: 'River pod'),
          CustomContainer(
              image:
                  'assets/images/WhatsApp Image 2024-02-25 at 16.49.29_583becb4.jpg',
              text: 'Provider'),
        ],
      ),
      const SizedBox(
        height: 30,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CustomContainer(
              image: 'assets/images/7131906.jpg', text: 'Api'),
          const CustomContainer(
              image:
                  'assets/images/WhatsApp Image 2024-02-25 at 16.50.08_eb99b2ed.jpg',
              text: 'bloc'),
          CustomContainer(
              image: AppImage.datastructure, text: 'Data structure'),
        ],
      ),
    ]);
  }
}
