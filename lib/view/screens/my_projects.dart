import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return HelperClass(
      paddingWidth: size.width * 0.1,
      bgColor: Colors.transparent, // Let main background flow through
      mobile: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(isMobile),
          const SizedBox(height: 40),
          buildProjectGridView(crossAxisCount: 1, isMobile: true),
        ],
      ),
      tablet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(false),
          const SizedBox(height: 40),
          buildProjectGridView(crossAxisCount: 2, isMobile: false),
        ],
      ),
      desktop: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(false),
          const SizedBox(height: 40),
          buildProjectGridView(crossAxisCount: 3, isMobile: false),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return FadeInDown(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'EXPLORE MY WORK',
                style: GoogleFonts.bebasNeue(
                  fontSize: 14,
                  letterSpacing: 1.5,
                  color: AppColors.turquoise300,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'SELECTED PROJECTS',
                style: GoogleFonts.bebasNeue(
                  fontSize: isMobile ? 32 : 44,
                  color: AppColors.slateWhite,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          if (!isMobile)
            GestureDetector(
              onTap: () => launchURL('https://github.com/Akshaykpz'),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'VIEW ALL PROJECTS',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 14,
                        letterSpacing: 1,
                        color: AppColors.slateWhite,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_right_alt,
                      color: AppColors.turquoise300,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildProjectGridView({
    required int crossAxisCount,
    required bool isMobile,
  }) {
    final List<String> appset = [
      AppImage.project1,
      AppImage.project2,
      AppImage.wheather,
      AppImage.netflix,
      AppImage.music,
      AppImage.taskManger
    ];

    final List<String> githubProject = [
      'https://github.com/Akshaykpz/StoreX-E-commerce-application',
      'https://github.com/Akshaykpz/AquaMed-Tracker',
      'https://github.com/Akshaykpz/Wheather-App',
      'https://github.com/Akshaykpz/netflix',
      'https://github.com/Akshaykpz/music_player-',
      'https://github.com/Akshaykpz/chatwave'
    ];

    final List<String> projects = [
      'StoreX',
      'AquaMed Tracker',
      'Weather-App',
      'Netflix Clone',
      'Music Player',
      'ChatWave'
    ];

    final List<String> projectCategories = [
      'E-COMMERCE APP',
      'MED TRACKER & HEALTH',
      'LIVE WEATHER FORECASTS',
      'STREAMING SERVICE CLONE',
      'OFFLINE MUSIC PLAYER',
      'REAL-TIME CHAT SERVICE'
    ];

    final List<String> projectContent = [
      'Developed an e-commerce platform that integrates real-time database updates, user profiles, and catalog browsing.',
      'Medication scheduler and reminder system. Features include medicine timings, dosages, and water intake tracker.',
      'Weather tracker providing real-time forecasts, atmospheric updates, and search capabilities using location APIs.',
      'Movie library streaming application inspired by Netflix, utilizing the TMDb REST API for content discovery.',
      'Offline media player featuring local music library indexing, sleek playback controls, and background audio support.',
      'Real-time communication application with a robust Node.js backend, custom message sockets, and PostgreSQL data store.'
    ];

    return GridView.builder(
      itemCount: appset.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 310,
        mainAxisSpacing: 32,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        return ProjectCard(
          index: index,
          image: appset[index],
          title: projects[index],
          category: projectCategories[index],
          description: projectContent[index],
          githubUrl: githubProject[index],
          isMobile: isMobile,
        );
      },
    );
  }

  void launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ProjectCard extends StatefulWidget {
  final int index;
  final String image;
  final String title;
  final String category;
  final String description;
  final String githubUrl;
  final bool isMobile;

  const ProjectCard({
    Key? key,
    required this.index,
    required this.image,
    required this.title,
    required this.category,
    required this.description,
    required this.githubUrl,
    required this.isMobile,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  void launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayIndex = (widget.index + 1).toString().padLeft(2, '0');

    return FadeInUp(
      duration: Duration(milliseconds: 600 + (widget.index * 100)),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => launchURL(widget.githubUrl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image Frame
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isHovered
                          ? AppColors.turquoise300
                          : AppColors.slate900,
                      width: 1,
                    ),
                    boxShadow: [
                      if (isHovered)
                        BoxShadow(
                          color: AppColors.turquoise300.withOpacity(0.12),
                          blurRadius: 20,
                          spreadRadius: -4,
                        ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Image with hover zoom
                        AnimatedScale(
                          scale: isHovered ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 400),
                          child: Image.asset(
                            widget.image,
                            fit: BoxFit.cover,
                            cacheWidth: widget.isMobile ? 360 : 560,
                          ),
                        ),
                        // Dark overlay on hover showing description text
                        AnimatedOpacity(
                          opacity: isHovered ? 0.92 : 0.0,
                          duration: const Duration(milliseconds: 250),
                          child: Container(
                            color: Colors.black,
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.title,
                                  style: GoogleFonts.bebasNeue(
                                    fontSize: 22,
                                    letterSpacing: 1,
                                    color: AppColors.turquoise300,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.description,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.slate300,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.turquoise300,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'VIEW SOURCE',
                                        style: GoogleFonts.bebasNeue(
                                          fontSize: 12,
                                          color: AppColors.slateWhite,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      const Icon(
                                        Icons.code,
                                        size: 14,
                                        color: AppColors.turquoise300,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Project metadata below image
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    displayIndex,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 24,
                      color: AppColors.turquoise300,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title.toUpperCase(),
                          style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: AppColors.slateWhite,
                            letterSpacing: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.category,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate400,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isHovered ? -0.125 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.arrow_outward,
                      color: isHovered
                          ? AppColors.turquoise300
                          : AppColors.slate500,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
