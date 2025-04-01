import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:animate_do/animate_do.dart';
import 'package:my_personal_website/helper/helper_class.dart';

class Expierence extends StatefulWidget {
  const Expierence({Key? key}) : super(key: key);

  @override
  State<Expierence> createState() => _ExpierenceState();
}

class _ExpierenceState extends State<Expierence> {
  bool isoffhover = false, isdata = false, isonHover = false;
  final isHoverActive = Matrix4.identity()..translate(0, -10, 0);
  final isHoverRemove = Matrix4.identity()..translate(0, 0, 0);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return HelperClass(
      paddingWidth: size.width * 0.1,
      bgColor: AppColors.bgcolors,
      mobile: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          fadetext(),
          const SizedBox(height: 20),
          Text(
            'Experience My work experience as a Flutter Developer and working on different companies and projects',
            style: Apptext.aboutstyles(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                isonHover = value;
              });
            },
            child: animatedContiner(
              context,
              'assets/images/427998075_917323277061139_5829715538073830577_n.jpg',
              isonHover,
              'Flutter Developer',
              'Grapes IDMR - Info Park Trissur',
              ' May 2024 - April 2025',
              '',
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                isoffhover = value;
              });
            },
            child: animatedContiner(
              context,
              'assets/images/WhatsApp Image 2024-02-29 at 18.41.19_76132ea6.jpg',
              isoffhover,
              ' Flutter Developer',
              'Brototype - Calcut',
              ' April 2023 - Feb March',
              'I have a solid foundation in Flutter Development, acquired through a successful internship at Brototype. Over the subsequent eight months, I accomplished the delivery of two significant projects, in addition to several mini-projects,',
            ),
          ),
        ],
      ),
      tablet: Column(
        children: [expierenceFilter(context)],
      ),
      desktop: Column(
        children: [expierenceFilter(context)],
      ),
    );
  }

  expierenceFilter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        fadetext(),
        const SizedBox(height: 20),
        Text(
          'Experience My work experience as a Flutter Developer and working on different companies and projects',
          style: Apptext.aboutstyles(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              onHover: (value) {
                setState(() {
                  isonHover = value;
                });
              },
              child: animatedContiner(
                context,
                'assets/images/427998075_917323277061139_5829715538073830577_n.jpg',
                isonHover,
                'Flutter Developer',
                'Grapes IDMR - Info Park Trissur',
                ' May 2024 - April 2025',
                '',
              ),
            ),
            const SizedBox(width: 100),
            InkWell(
              onTap: () {},
              onHover: (value) {
                setState(() {
                  isoffhover = value;
                });
              },
              child: animatedContiner(
                context,
                'assets/images/WhatsApp Image 2024-02-29 at 18.41.19_76132ea6.jpg',
                isoffhover,
                ' Flutter Developer',
                'Brototype - Calcut',
                ' April 2023 - Feb March',
                'I have a solid foundation in Flutter Development, acquired through a successful internship at Brototype. Over the subsequent eight months, I accomplished the delivery of two significant projects, in addition to several mini-projects,',
              ),
            ),
          ],
        ),
      ],
    );
  }

  FadeInDown fadetext() {
    return FadeInDown(
      child: RichText(
        text: TextSpan(
          text: 'Experience',
          style: Apptext.addstyles(Colors.white),
        ),
      ),
    );
  }

  Widget animatedContiner(
    BuildContext context,
    String image,
    bool isHover,
    String text1,
    String text2,
    String text3,
    String text4,
  ) {
    double containerWidth = 500;
    double containerHeight = 530;
    double imageSize = 70;
    // final double fontSize = MediaQuery.of(context).size.width * 0.01;

    return AnimatedContainer(
      transform: isHover ? isHoverActive : isHoverRemove,
      width: isHover ? containerHeight : containerWidth,
      height: isHover ? 250 : 270,
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(0, 0, 0, 0.122),
        // gradient: const LinearGradient(
        //   colors: [Colors.blue, Colors.purple],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        border: Border.all(
          color: Colors.white,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Column(
        // Change from Column to Row
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              width: imageSize,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text1,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                text2,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                text3,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  text4,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
