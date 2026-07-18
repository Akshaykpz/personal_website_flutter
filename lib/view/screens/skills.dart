import 'package:flutter/material.dart';
import 'package:my_personal_website/app/app_typography.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: 72,
      ),
      child: Center(child: skillsColumn()),
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
            style: GoogleFonts.manrope(
              color: Colors.white70,
              fontSize: 16,
              height: 1.7,
            ),
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

  Widget fadetext() {
    return Column(
      children: [
        Text(
          'Capabilities',
          style: GoogleFonts.jetBrainsMono(
            color: const Color(0xFF22D3EE),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'My Skills',
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white,
            fontSize: 44,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 132,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.code_rounded,
                  color: Color(0xFF22D3EE),
                  size: 42,
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.jetBrainsMono(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
