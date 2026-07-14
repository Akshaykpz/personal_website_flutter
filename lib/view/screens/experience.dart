import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_personal_website/constants/box.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';

class Expierence extends StatelessWidget {
  const Expierence({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final List<Map<String, String>> experiences = [
      {
        'image': 'assets/images/website.png',
        'role': 'Flutter Developer',
        'company': 'Genova Technologies Pvt Ltd',
        'period': 'June 2025 - Present',
        'description': 'Software company in Kozhikode, Kerala.',
      },
      {
        'image': 'assets/images/427998075_917323277061139_5829715538073830577_n.jpg',
        'role': 'Flutter Developer',
        'company': 'Grapes IDMR - Info Park Trissur',
        'period': 'May 2024 - April 2025',
        'description': '',
      },
      {
        'image': 'assets/images/WhatsApp Image 2024-02-29 at 18.41.19_76132ea6.jpg',
        'role': 'Flutter Developer',
        'company': 'Brototype - Calicut',
        'period': 'April 2023 - April 2024',
        'description': '',
      },
    ];

    return HelperClass(
      paddingWidth: size.width * 0.1,
      bgColor: Colors.transparent,
      mobile: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: experiences.map((exp) {
              return ExperienceCard(
                image: exp['image']!,
                role: exp['role']!,
                company: exp['company']!,
                period: exp['period']!,
                description: exp['description']!,
              );
            }).toList(),
          ),
        ],
      ),
      tablet: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 60),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: experiences.map((exp) {
              return ExperienceCard(
                image: exp['image']!,
                role: exp['role']!,
                company: exp['company']!,
                period: exp['period']!,
                description: exp['description']!,
              );
            }).toList(),
          ),
        ],
      ),
      desktop: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 60),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: experiences.map((exp) {
              return ExperienceCard(
                image: exp['image']!,
                role: exp['role']!,
                company: exp['company']!,
                period: exp['period']!,
                description: exp['description']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      child: Column(
        children: [
          Text('WORK HISTORY', style: Apptext.monoLabel()),
          const SizedBox(height: 8),
          Text(
            'EXPERIENCE',
            style: Apptext.addstyles(AppColors.slateWhite),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatefulWidget {
  final String image;
  final String role;
  final String company;
  final String period;
  final String description;

  const ExperienceCard({
    Key? key,
    required this.image,
    required this.role,
    required this.company,
    required this.period,
    this.description = '',
  }) : super(key: key);

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool isHover = false;
  final isHoverActive = Matrix4.identity()..translate(0, -8, 0);
  final isHoverRemove = Matrix4.identity()..translate(0, 0, 0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final containerWidth = width < 768
        ? width - 36
        : width < 1200
            ? 300.0
            : 360.0;
    const imageSize = 56.0;

    return InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () {},
      onHover: (value) => setState(() => isHover = value),
      child: AnimatedContainer(
        transform: isHover ? isHoverActive : isHoverRemove,
        width: containerWidth,
        constraints: const BoxConstraints(minHeight: 230),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        decoration: Colorss.surfaceDecoration(isHover: isHover),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                    width: imageSize,
                    height: imageSize,
                    cacheWidth: 112,
                    cacheHeight: 112,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.role,
                    style: Apptext.aboutstyles1(17).copyWith(
                      fontWeight: FontWeight.bold,
                      color: isHover ? AppColors.turquoise300 : AppColors.slateWhite,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(widget.company, style: Apptext.aboutstyles()),
            const SizedBox(height: 8),
            Text(
              widget.period,
              style: GoogleFonts.ibmPlexMono(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.turquoise300,
              ),
            ),
            if (widget.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                widget.description,
                style: Apptext.aboutstyles2(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
