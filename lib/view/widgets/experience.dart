import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/textstyle.dart';

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
    return SizedBox(
      height: 400,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          FadeInDown(
              child: RichText(
                  text: TextSpan(
            text: 'Experience',
            style: Apptext.addstyles(Colors.white),
          ))),
          const SizedBox(
            height: 20,
          ),
          Text(
            'ExperienceMy work experience as a Flutter Developer and working on different companies and projects',
            style: Apptext.aboutstyles(),
          ),
          const SizedBox(
            height: 20,
          ),
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
                    'assets/images/WhatsApp Image 2024-02-29 at 11.56.24_4da76985.jpg',
                    isonHover,
                    ': Flutter Developer',
                    '  : Grand Cafe Production',
                    ': Nov 2023 - Jan 2024',
                    'Working on Rental Platforms,managing Both Frontend&Backend, and Figam design from the scrach'),
              ),
              const SizedBox(
                width: 30,
              ),
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
                    ': Flutter Developer',
                    'Brototype',
                    ': Jan 2023 - Nov 2023',
                    'I have a solid foundation in Flutter Developemnet, acquired through a successful internship at Brototype. Over the subsequent eight months, I accomplished the delivery of two significant projects, in addition to several mini-projects, showcasing my proficiency and commitment in the field'),
              ),
            ],
          )
        ],
      ),
    );
  }

  AnimatedContainer animatedContiner(BuildContext context, String image,
      bool ishover, String text1, String text2, String text3, String text4) {
    return AnimatedContainer(
      transform: ishover ? isHoverActive : isHoverRemove,
      width: ishover
          ? MediaQuery.of(context).size.width * 0.3 * 1.1
          : MediaQuery.of(context).size.width * 0.3,
      height: ishover ? 200 : 220,
      duration: const Duration(seconds: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(0, 0, 0, 0.122),
        gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        border: Border.all(
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Image.asset(
                image,
                height: 50,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  text1,
                  style: Apptext.aboutstyles1(),
                ),
                Text(
                  text2,
                  style: Apptext.aboutstyles2(),
                ),
                Text(
                  text3,
                  style: Apptext.aboutstyles2(),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text4,
            style: Apptext.aboutstyles2(),
          ),
        )
      ]),
    );
  }
}
