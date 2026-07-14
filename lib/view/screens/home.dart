import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_personal_website/constants/box.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';

import 'dart:html' as html;

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isResumeHover = false;
  bool isWorkHover = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final isMobile = size.width < 992; // 992px threshold for three-column layout

    return Stack(
      alignment: Alignment.center,
      children: [
        // Giant Background Text
        Positioned(
          top: isMobile ? 80 : 40,
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.05,
              child: Text(
                'PORTFOLIO',
                style: GoogleFonts.bebasNeue(
                  fontSize: isMobile ? 90 : size.width * 0.15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.turquoise300, // Crimson Red
                  letterSpacing: 10,
                ),
              ),
            ),
          ),
        ),
        HelperClass(
          paddingWidth: size.width * 0.08,
          bgColor: Colors.transparent, // Let background stack colors pass through
          mobile: Column(
            children: [
              const SizedBox(height: 56), // Push content below mobile navbar
              buildHomeMethod(size, isMobile: true),
              const SizedBox(height: 48),
              buildHeroVisual(size, isMobile: true),
            ],
          ),
          tablet: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 96), // Push content below tablet navbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 5, child: buildHomeMethod(size)),
                  const SizedBox(width: 32),
                  buildHeroVisual(size),
                  const SizedBox(width: 32),
                  Expanded(flex: 3, child: buildRightColumn(size)),
                ],
              ),
            ],
          ),
          desktop: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 110), // Push content below desktop navbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 5, child: buildHomeMethod(size)),
                  const SizedBox(width: 48),
                  buildHeroVisual(size),
                  const SizedBox(width: 48),
                  Expanded(flex: 3, child: buildRightColumn(size)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  SlideInDown buildHomeMethod(Size size, {bool isMobile = false}) {
    return SlideInDown(
      duration: const Duration(seconds: 1),
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          FadeInDown(
            child: Text(
              "Hello, I'm",
              style: GoogleFonts.satisfy(
                fontSize: isMobile ? 32 : 44,
                color: AppColors.turquoise300,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
          ),
          const SizedBox(height: 8),
          FadeInDown(
            child: Text(
              'AKSHAY KP',
              style: GoogleFonts.bebasNeue(
                fontSize: isMobile ? 56 : 88,
                fontWeight: FontWeight.bold,
                color: AppColors.slateWhite,
                letterSpacing: 2,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
          ),
          const SizedBox(height: 4),
          FadeInDown(
            child: Text(
              'FLUTTER DEVELOPER & UI/UX CREATOR',
              style: GoogleFonts.inter(
                fontSize: isMobile ? 12 : 14,
                fontWeight: FontWeight.w700,
                color: AppColors.turquoise300,
                letterSpacing: 1.5,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
          ),
          const SizedBox(height: 20),
          FadeInDown(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Text(
                'I design and build stylish, user-focused web and mobile experiences. Passionate about clean design, smooth animations, and product details that make a difference.',
                style: Apptext.aboutstyles(),
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
              ),
            ),
          ),
          const SizedBox(height: 28),
          FadeInUp(
            child: Wrap(
              spacing: 14,
              runSpacing: 14,
              alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => isResumeHover = true),
                  onExit: (_) => setState(() => isResumeHover = false),
                  child: GestureDetector(
                    onTap: () => downloadFile(
                      'assets/assets/images/Akshay KP.resume.pdf',
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration:
                          Colorss.pillDecoration(isHover: isResumeHover),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Download CV',
                              style: Apptext.buttonText(
                                  AppColors.slateBlack)),
                          const SizedBox(width: 12),
                          AnimatedRotation(
                            turns: isResumeHover ? 0.125 : 0,
                            duration: const Duration(milliseconds: 260),
                            child: const Icon(
                              Icons.arrow_outward,
                              color: AppColors.slateBlack,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => isWorkHover = true),
                  onExit: (_) => setState(() => isWorkHover = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    decoration:
                        Colorss.ghostPillDecoration(isHover: isWorkHover),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View Projects',
                          style: Apptext.buttonText(AppColors.slateWhite),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.grid_view_rounded,
                          color: isWorkHover
                              ? AppColors.turquoise300
                              : AppColors.slate400,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isMobile) ...[
            const SizedBox(height: 40),
            FadeInUp(
              child: Wrap(
                spacing: 32,
                runSpacing: 18,
                alignment: WrapAlignment.center,
                children: const [
                  _HeroStat(value: '3+', label: 'YEARS EXPERIENCE'),
                  _HeroStat(value: '12+', label: 'PROJECTS COMPLETED'),
                  _HeroStat(value: '3', label: 'PLATFORMS ACTIVE'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildHeroVisual(Size size, {bool isMobile = false}) {
    final width = isMobile ? 260.0 : 320.0;
    final height = isMobile ? 360.0 : 440.0;
    return FadeInRight(
      duration: const Duration(milliseconds: 900),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.turquoise300.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.turquoise300.withOpacity(0.08),
              blurRadius: 30,
              spreadRadius: -10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/profile_pic.jpg',
                fit: BoxFit.cover,
                cacheWidth: isMobile ? 320 : 480,
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.65),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.greenAccent,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'AVAILABLE FOR FREELANCE',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 16,
                            letterSpacing: 1.2,
                            color: AppColors.turquoise300,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'DELIVERING WORLDWIDE',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.slate300,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRightColumn(Size size) {
    return FadeInRight(
      duration: const Duration(milliseconds: 900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.stars_sharp,
                color: AppColors.turquoise300,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Turning ideas\ninto powerful\ndigital experiences.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.slate300,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Container(
            width: 80,
            height: 1,
            color: AppColors.slate900,
          ),
          const SizedBox(height: 36),
          const _HeroStatStacked(value: '3+', label: 'YEARS\nEXPERIENCE'),
          const SizedBox(height: 24),
          const _HeroStatStacked(value: '12+', label: 'PROJECTS\nCOMPLETED'),
          const SizedBox(height: 24),
          const _HeroStatStacked(value: '3', label: 'PLATFORMS\nACTIVE'),
        ],
      ),
    );
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = "Akshay kp resume";
    anchorElement.click();
  }
}

class _HeroStat extends StatelessWidget {
  final String value;
  final String label;

  const _HeroStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final words = label.split(' ');
    final topLabel = words.isNotEmpty ? words[0] : '';
    final bottomLabel = words.length > 1 ? words.sublist(1).join(' ') : '';

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: GoogleFonts.bebasNeue(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            color: AppColors.turquoise300,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              topLabel,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.slateWhite,
                letterSpacing: 0.5,
              ),
            ),
            if (bottomLabel.isNotEmpty)
              Text(
                bottomLabel,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: AppColors.slate400,
                  letterSpacing: 0.5,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _HeroStatStacked extends StatelessWidget {
  final String value;
  final String label;

  const _HeroStatStacked({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            value,
            style: GoogleFonts.bebasNeue(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.turquoise300,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.slateWhite,
              letterSpacing: 0.5,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
