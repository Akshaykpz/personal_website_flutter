import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/view/widgets/circile_view.dart';
import 'package:url_launcher/url_launcher.dart';

class FotterClass extends StatelessWidget {
  const FotterClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        color: AppColors.bgcolors1,
        child: Row(
          children: [
            CircileView(
              image: AppImage.oneimage,
            ),
            CircileView(
              image: AppImage.hello,
              voidCallback: () {
                const linkedin =
                    'https://www.linkedin.com/in/akshay-kp-931056219/';
                launchUrl(Uri.parse(linkedin), mode: LaunchMode.inAppWebView);
              },
            ),
            CircileView(image: AppImage.instagram),
            CircileView(image: AppImage.twitter),
          ],
        ),
      ),
    );
  }
}
