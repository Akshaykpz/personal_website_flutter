import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';

class MyService extends StatelessWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final isMobile = size.width < 992;

    return HelperClass(
      paddingWidth: size.width * 0.1,
      bgColor: Colors.transparent, // Let background stack flow through
      mobile: _buildMobileLayout(),
      tablet: _buildDesktopLayout(size, isTablet: true),
      desktop: _buildDesktopLayout(size, isTablet: false),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(isMobile: true),
        const SizedBox(height: 40),
        _buildProcessSteps(isMobile: true),
        const SizedBox(height: 48),
        _buildQuoteCard(isMobile: true),
      ],
    );
  }

  Widget _buildDesktopLayout(Size size, {required bool isTablet}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(isMobile: false),
        const SizedBox(height: 60),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: isTablet ? 4 : 5,
              child: _buildProcessSteps(isMobile: false),
            ),
            const SizedBox(width: 48),
            Expanded(
              flex: 3,
              child: _buildQuoteCard(isMobile: false),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeader({required bool isMobile}) {
    return FadeInDown(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HOW I WORK',
            style: GoogleFonts.bebasNeue(
              fontSize: 14,
              letterSpacing: 1.5,
              color: AppColors.turquoise300,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'WORK PROCESS',
            style: GoogleFonts.bebasNeue(
              fontSize: isMobile ? 32 : 44,
              color: AppColors.slateWhite,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessSteps({required bool isMobile}) {
    final List<Map<String, dynamic>> steps = [
      {
        'number': '01',
        'icon': Icons.search,
        'title': 'DISCOVER',
        'description': 'Understanding goals, target audience, and project requirements.',
      },
      {
        'number': '02',
        'icon': Icons.lightbulb_outline,
        'title': 'IDEATE',
        'description': 'Planning, wireframing, and mapping out the user experience concepts.',
      },
      {
        'number': '03',
        'icon': Icons.brush_outlined,
        'title': 'DESIGN',
        'description': 'Crafting details, visual hierarchies, and stunning design system components.',
      },
      {
        'number': '04',
        'icon': Icons.code_rounded,
        'title': 'DEVELOP',
        'description': 'Building fast, responsive, clean, and interactive Flutter applications.',
      },
      {
        'number': '05',
        'icon': Icons.rocket_launch_outlined,
        'title': 'DELIVER',
        'description': 'Rigorous testing, optimization, publishing, and launch monitoring.',
      },
    ];

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isLast = index == steps.length - 1;

        return FadeInLeft(
          duration: Duration(milliseconds: 500 + (index * 100)),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline Graphics Column
                Column(
                  children: [
                    // Number label
                    Text(
                      step['number'],
                      style: GoogleFonts.bebasNeue(
                        fontSize: 12,
                        color: AppColors.slate500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Icon Circle
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.slate950,
                        border: Border.all(
                          color: AppColors.turquoise300.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        step['icon'],
                        color: AppColors.turquoise300,
                        size: 20,
                      ),
                    ),
                    // Connecting line
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 1,
                          color: AppColors.turquoise300.withOpacity(0.18),
                        ),
                      ),
                    if (isLast) const SizedBox(height: 16),
                  ],
                ),
                const SizedBox(width: 24),
                // Text Column
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['title'],
                          style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: AppColors.slateWhite,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step['description'],
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.slate300,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuoteCard({required bool isMobile}) {
    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              AppColors.turquoise300.withOpacity(0.04),
              AppColors.turquoise500.withOpacity(0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: AppColors.turquoise300.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.turquoise300.withOpacity(0.04),
              blurRadius: 40,
              spreadRadius: -10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.format_quote_rounded,
              color: AppColors.turquoise300,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              'Good design is not just how it looks, but how it works.',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: AppColors.slateWhite,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '— AKSHAY',
              style: GoogleFonts.satisfy(
                fontSize: 24,
                color: AppColors.turquoise300,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 40),
            Divider(color: AppColors.turquoise300.withOpacity(0.12), height: 1),
            const SizedBox(height: 32),
            Text(
              "LET'S CREATE\nSOMETHING GREAT\nTOGETHER.",
              style: GoogleFonts.bebasNeue(
                fontSize: 28,
                color: AppColors.slateWhite,
                letterSpacing: 1.5,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
