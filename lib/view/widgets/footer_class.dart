import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/view/widgets/circile_view.dart';
import 'package:url_launcher/url_launcher.dart';

class FotterClass extends StatefulWidget {
  const FotterClass({Key? key}) : super(key: key);

  @override
  State<FotterClass> createState() => _FotterClassState();
}

class _FotterClassState extends State<FotterClass> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        color: AppColors.bgcolors1,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircileView(
                  image: AppImage.twitter2,
                  voidCallback: () =>
                      launchURL('https://twitter.com/home?lang=en'),
                ),
                const SizedBox(
                  width: 15,
                ),
                CircileView(
                  image: AppImage.hello,
                  voidCallback: () => launchURL(
                      'https://www.linkedin.com/in/akshay-kp-931056219/'),
                ),
                const SizedBox(
                  width: 15,
                ),
                CircileView(
                    image: AppImage.instagram,
                    voidCallback: () =>
                        launchURL('https://www.instagram.com/),')),
                const SizedBox(
                  width: 15,
                ),
                CircileView(
                  image: AppImage.twitter,
                  voidCallback: () => launchURL('https://github.com/Akshaykpz'),
                ),
              ],
            ),
            Text(
              '© 2024 Akshay K P. All rights reserved',
              style: Apptext.aboutstyles2(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
