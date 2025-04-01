import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/view/widgets/custom_continer.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  final ScrollController _scrollController =
      ScrollController(); // ✅ Attach ScrollController

  @override
  void dispose() {
    _scrollController.dispose(); // ✅ Properly dispose of ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
            vertical: size.width * 0.1,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              skillsColumn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget skillsColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        fadetext(),
        const SizedBox(height: 40),
        Text(
          'Here are some of my skills on which I have been working for the past one year',
          style: Apptext.aboutstyles(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Wrap(
          // ✅ Instead of Row, use Wrap to avoid overflow issues on small screens
          spacing: 60,
          runSpacing: 40,

          alignment: WrapAlignment.center,
          children: [
            const CustomContainer(
                image: 'assets/images/dart.png', text: 'Dart'),
            const CustomContainer(
                image: 'assets/images/flutter.png', text: 'Flutter'),
            const CustomContainer(
                image: 'assets/images/github.png', text: 'Git Hub'),
            const CustomContainer(
                image:
                    'assets/images/WhatsApp Image 2024-02-25 at 16.43.26_966c41bb.jpg',
                text: 'Hive'),
            const CustomContainer(
                image: 'assets/images/figma.png', text: 'Figma'),
            const CustomContainer(
                image:
                    'assets/images/WhatsApp Image 2024-02-25 at 16.46.58_f54a21e3.jpg',
                text: 'Getx'),
            const CustomContainer(
                image:
                    'assets/images/WhatsApp Image 2024-02-25 at 16.48.07_355e3ce5.jpg',
                text: 'River pod'),
            const CustomContainer(
                image:
                    'assets/images/WhatsApp Image 2024-02-25 at 16.49.29_583becb4.jpg',
                text: 'Provider'),
            const CustomContainer(
                image: 'assets/images/7131906.jpg', text: 'Api'),
            CustomContainer(image: AppImage.firebase, text: 'Firebase'),
            const CustomContainer(
                image: 'assets/images/7131906.jpg', text: 'Api'),
            const CustomContainer(
                image:
                    'assets/images/WhatsApp Image 2024-02-25 at 16.50.08_eb99b2ed.jpg',
                text: 'bloc'),
          ],
        ),
      ],
    );
  }

  FadeInDown fadetext() {
    return FadeInDown(
      child: RichText(
        text: TextSpan(
          text: 'My',
          style: Apptext.addstyles(Colors.white),
          children: [
            TextSpan(
              text: '  Skills',
              style: Apptext.addstyles(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
