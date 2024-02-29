import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/textstyle.dart';

class Expierence extends StatelessWidget {
  const Expierence({Key? key}) : super(key: key);

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
              animatedContiner(
                  context,
                  'assets/images/WhatsApp Image 2024-02-29 at 11.56.24_4da76985.jpg',
                  ': Flutter Developer',
                  '  : Grand Cafe Production',
                  ': Nov 2023 - Jan 2024',
                  'Working on Rental Platforms,managing Both Frontend&Backend, and Figam design from the scrach'),

              // animatedContiner(context),
            ],
          )
        ],
      ),
    );
  }

  AnimatedContainer animatedContiner(BuildContext context, String image,
      String text1, String text2, String text3, String text4) {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black12,
        border: Border.all(
          style: BorderStyle.solid,
          width: 1,
          color: Colors.white24,
        ),
      ),
      height: 200,
      width: MediaQuery.of(context).size.width * 0.3,
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
