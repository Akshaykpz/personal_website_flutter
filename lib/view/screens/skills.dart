import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';
import 'package:my_personal_website/view/widgets/custom_continer.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: HelperClass(
        paddingWidth: size.width * 0.1,
        bgColor: Colors.transparent,
        mobile: skillsColumn(),
        tablet: skillsColumn(),
        desktop: skillsColumn(),
      ),
    );
  }

  Widget skillsColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        fadetext(),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            'A focused stack for shipping Flutter interfaces, API-connected flows, and production-ready mobile/web experiences.',
            style: Apptext.aboutstyles(),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 48),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            CustomContainer(image: 'assets/images/dart.png', text: 'Dart'),
            CustomContainer(
              image: 'assets/images/flutter.png',
              text: 'Flutter',
            ),
            CustomContainer(image: 'assets/images/github.png', text: 'GitHub'),
            CustomContainer(image: 'assets/images/figma.png', text: 'Figma'),
            CustomContainer(image: 'assets/images/9618513.webp', text: 'API'),
            CustomContainer(image: 'assets/images/sql.png', text: 'SQL'),
          ],
        ),
      ],
    );
  }

  FadeInDown fadetext() {
    return FadeInDown(
      child: Column(
        children: [
          Text('Capabilities', style: Apptext.monoLabel()),
          const SizedBox(height: 8),
          Text(
            'My Skills',
            style: Apptext.addstyles(AppColors.slateWhite),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
