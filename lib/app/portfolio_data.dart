import 'package:flutter/material.dart';

enum PortfolioSectionId { home, about, skills, projects, experience, contact }

extension PortfolioSectionMeta on PortfolioSectionId {
  String get label {
    switch (this) {
      case PortfolioSectionId.home:
        return 'Home';
      case PortfolioSectionId.about:
        return 'About';
      case PortfolioSectionId.skills:
        return 'Skills';
      case PortfolioSectionId.projects:
        return 'Projects';
      case PortfolioSectionId.experience:
        return 'Experience';
      case PortfolioSectionId.contact:
        return 'Contact';
    }
  }
}

class PortfolioStat {
  const PortfolioStat({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;
}

class CapabilityItem {
  const CapabilityItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class SkillGroup {
  const SkillGroup({
    required this.title,
    required this.caption,
    required this.skills,
  });

  final String title;
  final String caption;
  final List<String> skills;
}

class PortfolioProject {
  const PortfolioProject({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.projectUrl,
    required this.tags,
  });

  final String title;
  final String description;
  final String imageAsset;
  final String projectUrl;
  final List<String> tags;
}

class ExperienceEntry {
  const ExperienceEntry({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.logoAsset,
  });

  final String role;
  final String company;
  final String period;
  final String description;
  final String? logoAsset;
}

const String portfolioName = 'Akshay K P';
const String portfolioRole = 'Flutter Developer';
const String portfolioLocation = 'Kerala, India';
const String portfolioGithubUrl = 'https://github.com/Akshaykpz';
const String portfolioLinkedInUrl =
    'https://www.linkedin.com/in/akshay-kp-931056219/';
const String portfolioResumeUrl = 'assets/assets/images/Akshay%20KP.resume.pdf';
const String emailJsServiceId = 'service_01uj5cm';
const String emailJsUserId = '6QkiRE5XFrLpJdZXu';
const String emailJsTemplateId = 'template_d7983hp';

const List<String> heroTitles = <String>[
  'Flutter Developer',
  'Responsive Web Builder',
  'Smooth UI Engineer',
];

const List<PortfolioStat> portfolioStats = <PortfolioStat>[
  PortfolioStat(value: '2+', label: 'Years building with Flutter'),
  PortfolioStat(value: '8', label: 'Featured projects shipped'),
  PortfolioStat(value: '3', label: 'Platforms across mobile and web'),
];

const List<CapabilityItem> capabilityItems = <CapabilityItem>[
  CapabilityItem(
    icon: Icons.flutter_dash_rounded,
    title: 'UI That Feels Premium',
    description:
        'I focus on polished motion, clean spacing, and responsive layouts that feel intentional instead of generic.',
  ),
  CapabilityItem(
    icon: Icons.rocket_launch_rounded,
    title: 'Performance First',
    description:
        'I simplify scroll-heavy layouts, reduce unnecessary rebuilds, and keep interfaces smooth on web and mobile.',
  ),
  CapabilityItem(
    icon: Icons.layers_outlined,
    title: 'Scalable Architecture',
    description:
        'I like building features with clear structure so future updates do not turn into fragile UI patches.',
  ),
  CapabilityItem(
    icon: Icons.auto_awesome_rounded,
    title: 'Product Mindset',
    description:
        'Beyond code, I care about how the final experience looks, feels, and communicates value to real users.',
  ),
];

const List<SkillGroup> skillGroups = <SkillGroup>[
  SkillGroup(
    title: 'Core Stack',
    caption: 'The tools I use most often for product delivery.',
    skills: <String>[
      'Flutter',
      'Dart',
      'REST APIs',
      'Responsive Web',
      'Firebase',
      'Provider',
    ],
  ),
  SkillGroup(
    title: 'UI Craft',
    caption: 'Where I spend extra time to make the product feel better.',
    skills: <String>[
      'Micro-interactions',
      'Scroll animation',
      'Figma handoff',
      'Layout systems',
      'Design polish',
      'Dark UI styling',
    ],
  ),
  SkillGroup(
    title: 'Workflow',
    caption: 'The supporting tools that keep shipping fast and stable.',
    skills: <String>[
      'GitHub',
      'Debugging',
      'Asset optimization',
      'API integration',
      'Release prep',
      'Team collaboration',
    ],
  ),
];

const List<PortfolioProject> portfolioProjects = <PortfolioProject>[
  PortfolioProject(
    title: 'StoreX',
    description:
        'An e-commerce Flutter app with catalog browsing, purchase flows, and a modern shopping experience.',
    imageAsset: 'assets/images/3810160.jpg',
    projectUrl: 'https://github.com/Akshaykpz/StoreX-E-commerce-application',
    tags: <String>['Flutter', 'Firebase', 'Commerce'],
  ),
  PortfolioProject(
    title: 'Aqua Med Tracker',
    description:
        'A medicine and water tracking app focused on reminders, daily habits, and practical health support.',
    imageAsset: 'assets/images/3905883.jpg',
    projectUrl: 'https://github.com/Akshaykpz/AquaMed-Tracker',
    tags: <String>['Flutter', 'Tracker', 'Reminders'],
  ),
  PortfolioProject(
    title: 'Weather App',
    description:
        'A real-time weather experience with forecast data, location context, and a quick-glance interface.',
    imageAsset: 'assets/images/4092.jpg',
    projectUrl: 'https://github.com/Akshaykpz/Wheather-App',
    tags: <String>['API', 'Location', 'Forecast'],
  ),
  PortfolioProject(
    title: 'Netflix UI Clone',
    description:
        'A streaming-inspired interface built around content browsing, clean sections, and visual hierarchy.',
    imageAsset: 'assets/images/wp5063339-netflix-logo-wallpapers.png',
    projectUrl: 'https://github.com/Akshaykpz/netflix',
    tags: <String>['UI', 'TMDb', 'Entertainment'],
  ),
  PortfolioProject(
    title: 'Music Player',
    description:
        'An offline-first music player with a simple playback flow and focus on a smooth listening experience.',
    imageAsset: 'assets/images/SL-022222-48740-15.jpg',
    projectUrl: 'https://github.com/Akshaykpz/music_player-',
    tags: <String>['Audio', 'Offline', 'Flutter'],
  ),
];

const List<ExperienceEntry> experienceEntries = <ExperienceEntry>[
  ExperienceEntry(
    role: 'Flutter Developer',
    company: 'Genova Technologies',
    period: 'June 2025 - Present',
    description:
        'Currently building Flutter applications with a focus on responsive layouts, polished user experience, and smooth product delivery across app and web.',
  ),
  ExperienceEntry(
    role: 'Flutter Developer',
    company: 'Grapes IDMR, Info Park Thrissur',
    period: 'May 2024 - April 2025',
    description:
        'Worked on Flutter product development with an emphasis on app features, cleaner UI delivery, and production-ready flows.',
    logoAsset:
        'assets/images/427998075_917323277061139_5829715538073830577_n.jpg',
  ),
  ExperienceEntry(
    role: 'Flutter Developer Trainee',
    company: 'Brototype, Calicut',
    period: '2023 - 2024',
    description:
        'Built hands-on Flutter projects, strengthened core engineering habits, and sharpened practical app development skills.',
    logoAsset:
        'assets/images/WhatsApp Image 2024-02-29 at 18.41.19_76132ea6.jpg',
  ),
];
