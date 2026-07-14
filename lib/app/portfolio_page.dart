import 'dart:convert';
import 'dart:async';
import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'portfolio_data.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  static const int _webProjectImageCacheWidth = 960;
  static const int _webProjectImageCacheHeight = 720;
  static const int _webLogoImageCacheSize = 136;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollProgress = ValueNotifier<double>(0.0);
  final ValueNotifier<int> _activeSection = ValueNotifier<int>(0);
  final Map<PortfolioSectionId, GlobalKey> _sectionKeys =
      <PortfolioSectionId, GlobalKey>{
    PortfolioSectionId.home: GlobalKey(),
    PortfolioSectionId.about: GlobalKey(),
    PortfolioSectionId.skills: GlobalKey(),
    PortfolioSectionId.projects: GlobalKey(),
    PortfolioSectionId.experience: GlobalKey(),
    PortfolioSectionId.contact: GlobalKey(),
  };
  final Map<PortfolioSectionId, double> _sectionVisibility =
      <PortfolioSectionId, double>{};
  final ValueNotifier<Offset?> _pointerPosition = ValueNotifier<Offset?>(null);
  final ValueNotifier<bool> _pointerVisible = ValueNotifier<bool>(false);

  late final AnimationController _loaderController;
  bool _hideLoader = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);

    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _loaderController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Future<void>.delayed(const Duration(milliseconds: 450), () {
          if (!mounted) {
            return;
          }
          setState(() {
            _hideLoader = true;
          });
        });
      }
    });
    _loaderController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleScroll();
      _warmUpImages();
    });
  }

  @override
  void dispose() {
    _loaderController.dispose();
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    _scrollProgress.dispose();
    _activeSection.dispose();
    _pointerPosition.dispose();
    _pointerVisible.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;
    if (!position.hasPixels) {
      return;
    }

    final maxScrollExtent = position.maxScrollExtent;
    final progress = maxScrollExtent <= 0
        ? 0.0
        : (position.pixels / maxScrollExtent).clamp(0.0, 1.0).toDouble();

    if (_scrollProgress.value != progress) {
      _scrollProgress.value = progress;
    }
  }

  Future<void> _warmUpImages() async {
    for (final project in portfolioProjects) {
      await precacheImage(
        _buildAssetProvider(
          project.imageAsset,
          cacheWidth: _webProjectImageCacheWidth,
          cacheHeight: _webProjectImageCacheHeight,
        ),
        context,
        onError: (_, __) {},
      );
    }

    for (final item in experienceEntries) {
      if (item.logoAsset == null) {
        continue;
      }

      await precacheImage(
        _buildAssetProvider(
          item.logoAsset!,
          cacheWidth: _webLogoImageCacheSize,
          cacheHeight: _webLogoImageCacheSize,
        ),
        context,
        onError: (_, __) {},
      );
    }
  }

  ImageProvider<Object> _buildAssetProvider(
    String asset, {
    int? cacheWidth,
    int? cacheHeight,
  }) {
    final provider = AssetImage(asset);
    if (!kIsWeb || cacheWidth == null) {
      return provider;
    }

    return ResizeImage(
      provider,
      width: cacheWidth,
      height: cacheHeight,
    );
  }

  void _updateSectionVisibility(
    PortfolioSectionId sectionId,
    VisibilityInfo info,
  ) {
    _sectionVisibility[sectionId] = info.visibleFraction;

    PortfolioSectionId? bestSection;
    double bestValue = 0.0;

    _sectionVisibility.forEach((PortfolioSectionId id, double value) {
      if (value > bestValue) {
        bestSection = id;
        bestValue = value;
      }
    });

    final currentBestSection = bestSection;

    if (currentBestSection != null && bestValue > 0.02) {
      final nextIndex = currentBestSection.index;

      if (_activeSection.value != nextIndex) {
        _activeSection.value = nextIndex;
      }
    }
  }

  Future<void> _scrollToSection(PortfolioSectionId sectionId) async {
    final targetKey = _sectionKeys[sectionId];
    final targetContext = targetKey?.currentContext;
    if (targetContext == null) {
      return;
    }

    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 950),
      curve: Curves.easeInOutCubic,
      alignment: sectionId == PortfolioSectionId.home ? 0.0 : 0.06,
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _pointerVisible.value = true;
      },
      onExit: (_) {
        _pointerVisible.value = false;
        _pointerPosition.value = null;
      },
      onHover: (PointerHoverEvent event) {
        _pointerVisible.value = true;
        _pointerPosition.value = event.position;
      },
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(
              child: _AnimatedBackdrop(),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    _trackedSection(
                      sectionId: PortfolioSectionId.home,
                      child: _HeroSection(
                        onPrimaryTap: () {
                          _scrollToSection(PortfolioSectionId.projects);
                        },
                      ),
                    ),
                    _trackedSection(
                      sectionId: PortfolioSectionId.about,
                      child: _SectionFrame(
                        sectionLabel: 'About',
                        title: '',
                        description: '',
                        child: _AboutSection(),
                      ),
                    ),
                    _trackedSection(
                      sectionId: PortfolioSectionId.skills,
                      child: _SectionFrame(
                        sectionLabel: 'Skills',
                        title: '',
                        description: '',
                        child: _SkillsSection(),
                      ),
                    ),
                    _trackedSection(
                      sectionId: PortfolioSectionId.projects,
                      child: _SectionFrame(
                        sectionLabel: 'Projects',
                        title: '',
                        description: '',
                        child: _ProjectsSection(
                          onProjectTap: (String url) {
                            _openUrl(url);
                          },
                        ),
                      ),
                    ),
                    _trackedSection(
                      sectionId: PortfolioSectionId.experience,
                      child: _SectionFrame(
                        sectionLabel: 'Experience',
                        title: '',
                        description: '',
                        child: _ExperienceSection(),
                      ),
                    ),
                    _trackedSection(
                      sectionId: PortfolioSectionId.contact,
                      child: _SectionFrame(
                        sectionLabel: 'Contact',
                        title: '',
                        description: '',
                        child: _ContactSection(
                          onGithubTap: () => _openUrl(portfolioGithubUrl),
                          onLinkedInTap: () => _openUrl(portfolioLinkedInUrl),
                        ),
                      ),
                    ),
                    const _FooterSection(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _TopProgressBar(progress: _scrollProgress),
            ),
            Positioned(
              top: 18,
              left: 0,
              right: 0,
              child: SafeArea(
                minimum: const EdgeInsets.symmetric(horizontal: 16),
                child: _PortfolioNav(
                  activeSection: _activeSection,
                  onSectionTap: (PortfolioSectionId sectionId) {
                    _scrollToSection(sectionId);
                  },
                ),
              ),
            ),
            Positioned(
              right: 18,
              top: 0,
              bottom: 0,
              child: SafeArea(
                child: _SectionRail(
                  activeSection: _activeSection,
                  onSectionTap: (PortfolioSectionId sectionId) {
                    _scrollToSection(sectionId);
                  },
                ),
              ),
            ),
            Positioned.fill(
              child: _PointerGlow(
                position: _pointerPosition,
                isVisible: _pointerVisible,
              ),
            ),
            if (!_hideLoader)
              Positioned.fill(
                child: _LoaderOverlay(controller: _loaderController),
              ),
          ],
        ),
      ),
    );
  }

  Widget _trackedSection({
    required PortfolioSectionId sectionId,
    required Widget child,
  }) {
    return KeyedSubtree(
      key: _sectionKeys[sectionId],
      child: VisibilityDetector(
        key: Key('section-${sectionId.index}'),
        onVisibilityChanged: (VisibilityInfo info) {
          _updateSectionVisibility(sectionId, info);
        },
        child: child,
      ),
    );
  }
}

class _AnimatedBackdrop extends StatefulWidget {
  const _AnimatedBackdrop();

  @override
  State<_AnimatedBackdrop> createState() => _AnimatedBackdropState();
}

class _AnimatedBackdropState extends State<_AnimatedBackdrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    );
    if (!kIsWeb) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final useStaticBackdrop =
        kIsWeb || MediaQuery.maybeOf(context)?.disableAnimations == true;
    if (useStaticBackdrop) {
      return RepaintBoundary(
        child: _buildBackdropScene(0.0, lightweight: true),
      );
    }

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          final t = _controller.value * math.pi * 2;
          return _buildBackdropScene(t, lightweight: false);
        },
      ),
    );
  }

  Widget _buildBackdropScene(double t, {required bool lightweight}) {
    final gridAlpha = lightweight ? 0.026 : 0.045;
    final motion = lightweight ? 0.0 : 1.0;

    return Stack(
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFF040714),
                Color(0xFF070B1E),
                Color(0xFF04050E),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPainter(
              lineColor: Colors.white.withValues(alpha: gridAlpha),
            ),
          ),
        ),
        _GlowOrb(
          alignment: Alignment(
            -0.85 + math.sin(t) * 0.15 * motion,
            -0.8 + math.cos(t * 0.7) * 0.18 * motion,
          ),
          color: const Color(0xFFA855F7),
          size: lightweight ? 300 : 420,
        ),
        _GlowOrb(
          alignment: Alignment(
            0.85 + math.cos(t * 0.8) * 0.12 * motion,
            -0.4 + math.sin(t * 0.9) * 0.18 * motion,
          ),
          color: const Color(0xFF22D3EE),
          size: lightweight ? 240 : 320,
        ),
        _GlowOrb(
          alignment: Alignment(
            -0.15 + math.sin(t * 0.65) * 0.2 * motion,
            0.85 + math.cos(t * 0.75) * 0.12 * motion,
          ),
          color: const Color(0xFF7C3AED),
          size: lightweight ? 360 : 500,
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withValues(alpha: lightweight ? 0.14 : 0.18),
                  Colors.transparent,
                  Colors.black.withValues(alpha: lightweight ? 0.28 : 0.35),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.lineColor});

  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    const double gap = 42;
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor;
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.alignment,
    required this.color,
    required this.size,
  });

  final Alignment alignment;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                color.withValues(alpha: 0.24),
                color.withValues(alpha: 0.08),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopProgressBar extends StatelessWidget {
  const _TopProgressBar({required this.progress});

  final ValueNotifier<double> progress;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: progress,
      builder: (BuildContext context, double value, Widget? child) {
        return SizedBox(
          height: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value.clamp(0.0, 1.0).toDouble(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFFA855F7),
                      Color(0xFF22D3EE),
                      Color(0xFF8B5CF6),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PortfolioNav extends StatelessWidget {
  const _PortfolioNav({
    required this.activeSection,
    required this.onSectionTap,
  });

  final ValueNotifier<int> activeSection;
  final ValueChanged<PortfolioSectionId> onSectionTap;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 16 : 22,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF060A16).withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              text: 'AKSHAY',
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: -0.6,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: '.',
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFFA855F7),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (isCompact)
            PopupMenuButton<PortfolioSectionId>(
              tooltip: 'Navigate',
              color: const Color(0xFF0D1325),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              ),
              onSelected: onSectionTap,
              itemBuilder: (BuildContext context) {
                return PortfolioSectionId.values
                    .map(
                      (PortfolioSectionId section) =>
                          PopupMenuItem<PortfolioSectionId>(
                        value: section,
                        child: Text(
                          section.label,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                    .toList();
              },
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFA855F7).withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.menu_rounded, color: Colors.white),
              ),
            )
          else
            ValueListenableBuilder<int>(
              valueListenable: activeSection,
              builder: (BuildContext context, int current, Widget? child) {
                return Row(
                  children: [
                    for (final section in PortfolioSectionId.values)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: _NavChip(
                          label: section.label,
                          isActive: current == section.index,
                          onTap: () => onSectionTap(section),
                        ),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

class _NavChip extends StatelessWidget {
  const _NavChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFFA855F7).withValues(alpha: 0.16)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? const Color(0xFFA855F7).withValues(alpha: 0.34)
                : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: isActive ? Colors.white : Colors.white70,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _SectionRail extends StatelessWidget {
  const _SectionRail({
    required this.activeSection,
    required this.onSectionTap,
  });

  final ValueNotifier<int> activeSection;
  final ValueChanged<PortfolioSectionId> onSectionTap;

  @override
  Widget build(BuildContext context) {
    final showRail = MediaQuery.of(context).size.width >= 1120;
    if (!showRail) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF060A16).withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: activeSection,
          builder: (BuildContext context, int current, Widget? child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final section in PortfolioSectionId.values)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Tooltip(
                      message: section.label,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => onSectionTap(section),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          width: current == section.index ? 12 : 8,
                          height: current == section.index ? 28 : 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: current == section.index
                                ? const LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFA855F7),
                                      Color(0xFF22D3EE),
                                    ],
                                  )
                                : null,
                            color: current == section.index
                                ? null
                                : Colors.white.withValues(alpha: 0.16),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PointerGlow extends StatelessWidget {
  const _PointerGlow({
    required this.position,
    required this.isVisible,
  });

  final ValueNotifier<Offset?> position;
  final ValueNotifier<bool> isVisible;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 1024) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: ValueListenableBuilder<bool>(
        valueListenable: isVisible,
        builder: (BuildContext context, bool visible, Widget? child) {
          return ValueListenableBuilder<Offset?>(
            valueListenable: position,
            builder: (BuildContext context, Offset? offset, Widget? child) {
              if (!visible || offset == null) {
                return const SizedBox.shrink();
              }

              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 170),
                    curve: Curves.easeOut,
                    left: offset.dx - 180,
                    top: offset.dy - 180,
                    child: Container(
                      width: 360,
                      height: 360,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: <Color>[
                            const Color(0xFFA855F7).withValues(alpha: 0.2),
                            const Color(0xFF22D3EE).withValues(alpha: 0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOut,
                    left: offset.dx - 56,
                    top: offset.dy - 56,
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.11),
                        ),
                        gradient: RadialGradient(
                          colors: <Color>[
                            Colors.white.withValues(alpha: 0.04),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 80),
                    curve: Curves.easeOut,
                    left: offset.dx - 10,
                    top: offset.dy - 10,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.95),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color:
                                const Color(0xFFA855F7).withValues(alpha: 0.24),
                            blurRadius: 18,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 110),
                    curve: Curves.easeOut,
                    left: offset.dx - 3,
                    top: offset.dy - 3,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF050816),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.onPrimaryTap,
  });

  final VoidCallback onPrimaryTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isCompact = size.width < 980;
    final double topPadding = isCompact
        ? (size.width < 720 ? 110.0 : 122.0)
        : (size.height < 780 ? 94.0 : 122.0);
    final double bottomPadding = isCompact ? 24.0 : (size.height < 780 ? 16.0 : 24.0);

    final heroMinHeight = isCompact
        ? math.max(620.0, size.height * 0.72)
        : math.max(680.0, size.height * 0.78);

    return Container(
      constraints: BoxConstraints(minHeight: heroMinHeight),
      padding: EdgeInsets.fromLTRB(
        24,
        topPadding,
        24,
        bottomPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: isCompact
              ? ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _HeroCopy(
                          isCompact: true,
                          onPrimaryTap: onPrimaryTap,
                        ),
                        const SizedBox(height: 24),
                        const _HeroVisual(isCompact: true),
                      ],
                    ),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 12,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: _HeroCopy(
                            isCompact: false,
                            onPrimaryTap: onPrimaryTap,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 42),
                    Expanded(
                      flex: 10,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: _HeroVisual(isCompact: false),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.isCompact,
    required this.onPrimaryTap,
  });

  final bool isCompact;
  final VoidCallback? onPrimaryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCompact ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const _RevealOnScroll(
          delay: Duration(milliseconds: 100),
          child: _HeroTagLine(),
        ),
        SizedBox(height: isCompact ? 16 : 14),
        _RevealOnScroll(
          delay: const Duration(milliseconds: 220),
          child: Text(
            'HI, I\'M\n$portfolioName',
            textAlign: isCompact ? TextAlign.center : TextAlign.left,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              height: 0.92,
              letterSpacing: -2.4,
              fontSize: isCompact ? 56 : 78,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(height: isCompact ? 12 : 10),
        _RevealOnScroll(
          delay: const Duration(milliseconds: 340),
          child: SizedBox(
            height: isCompact ? 58 : 62,
            child: DefaultTextStyle(
              style: GoogleFonts.spaceGrotesk(
                fontSize: isCompact ? 28 : 36,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFB8C1FF),
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 900),
                animatedTexts: heroTitles
                    .map(
                      (String title) => FadeAnimatedText(
                        title,
                        duration: const Duration(milliseconds: 1800),
                        textStyle: GoogleFonts.spaceGrotesk(
                          fontSize: isCompact ? 28 : 36,
                          fontWeight: FontWeight.w700,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: <Color>[
                                Color(0xFFA855F7),
                                Color(0xFF22D3EE),
                              ],
                            ).createShader(
                              const Rect.fromLTWH(0, 0, 400, 90),
                            ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: isCompact ? 16 : 14),
        _RevealOnScroll(
          delay: const Duration(milliseconds: 470),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              'I design and build stylish, user-focused web and mobile experiences. Passionate about clean design, smooth animations, and product details that make a difference.',
              textAlign: isCompact ? TextAlign.center : TextAlign.left,
              style: GoogleFonts.manrope(
                color: Colors.white70,
                height: 1.7,
                fontSize: isCompact ? 16 : 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: isCompact ? 22 : 18),
        _RevealOnScroll(
          delay: const Duration(milliseconds: 620),
          child: Wrap(
            spacing: 14,
            runSpacing: 14,
            alignment: isCompact ? WrapAlignment.center : WrapAlignment.start,
            children: [
              _ActionButton(
                label: 'View Projects',
                onTap: onPrimaryTap ?? () {},
                filled: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        _RevealOnScroll(
          delay: const Duration(milliseconds: 740),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: isCompact ? WrapAlignment.center : WrapAlignment.start,
            children: portfolioStats
                .map(
                  (PortfolioStat stat) => _StatPill(stat: stat),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _HeroTagLine extends StatelessWidget {
  const _HeroTagLine();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
                color: const Color(0xFFA855F7).withValues(alpha: 0.28)),
            color: const Color(0xFFA855F7).withValues(alpha: 0.08),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF22D3EE),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Available for Flutter roles',
                style: GoogleFonts.jetBrainsMono(
                  color: Colors.white70,
                  letterSpacing: 0.2,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Text(
          portfolioLocation,
          style: GoogleFonts.jetBrainsMono(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _HeroVisual extends StatefulWidget {
  const _HeroVisual({required this.isCompact});

  final bool isCompact;

  @override
  State<_HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<_HeroVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visualHeight = widget.isCompact ? 440.0 : 540.0;
    final orbitSize = widget.isCompact ? 300.0 : 360.0;

    return _RevealOnScroll(
      delay: const Duration(milliseconds: 300),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SizedBox(
          height: visualHeight,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              final t = _controller.value * math.pi * 2;
              final floatY = math.sin(t * 1.15) * 12;
              final floatX = math.cos(t * 0.85) * 10;

              return Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(floatX, floatY),
                    child: Transform.rotate(
                      angle: t * 0.16,
                      child: Container(
                        width: orbitSize,
                        height: orbitSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: -t * 0.28,
                    child: Container(
                      width: orbitSize * 0.72,
                      height: orbitSize * 0.72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              const Color(0xFFA855F7).withValues(alpha: 0.18),
                        ),
                      ),
                    ),
                  ),
                  ...<Widget>[
                    _OrbitDot(
                      angle: t,
                      radius: orbitSize * 0.48,
                      color: const Color(0xFF22D3EE),
                    ),
                    _OrbitDot(
                      angle: t + 2.2,
                      radius: orbitSize * 0.34,
                      color: const Color(0xFFA855F7),
                    ),
                    _OrbitDot(
                      angle: -t * 1.2 + 1.1,
                      radius: orbitSize * 0.42,
                      color: Colors.white,
                    ),
                  ],
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: <Color>[
                              Color(0xFFA855F7),
                              Color(0xFF22D3EE),
                            ],
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color(0xFFA855F7)
                                  .withValues(alpha: 0.24),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Smooth UI',
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontSize: widget.isCompact ? 28 : 34,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Flutter  /  Web  /  Motion',
                        style: GoogleFonts.jetBrainsMono(
                          color: Colors.white54,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: widget.isCompact ? 18 : 24,
                    top: widget.isCompact ? 62 : 70,
                    child: const _FloatingInfoCard(
                      label: 'Focus',
                      value: 'Fast, polished product UI',
                    ),
                  ),
                  
                  Positioned(

                    right: widget.isCompact ? 22 : 30,

                    bottom: widget.isCompact ? 56 : 72,

                    child: const _FloatingInfoCard(

                      label: 'Current mode',

                      value: 'Responsive web portfolio',

                      alignEnd: true,

                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OrbitDot extends StatelessWidget {
  const _OrbitDot({
    required this.angle,
    required this.radius,
    required this.color,
  });

  final double angle;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(math.cos(angle) * radius, math.sin(angle) * radius),
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.34),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingInfoCard extends StatelessWidget {
  const _FloatingInfoCard({
    required this.label,
    required this.value,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF08101E).withValues(alpha: 0.88),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment:
            alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: GoogleFonts.jetBrainsMono(
              color: const Color(0xFF22D3EE),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            textAlign: alignEnd ? TextAlign.right : TextAlign.left,
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.stat});

  final PortfolioStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 184),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        color: Colors.white.withValues(alpha: 0.035),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stat.value,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            style: GoogleFonts.manrope(
              color: Colors.white60,
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
    required this.sectionLabel,
    required this.title,
    required this.description,
    required this.child,
  });

  final String sectionLabel;
  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sectionVerticalPadding = width < 720 ? 28.0 : 34.0;
    final headerToTitleGap = width < 720 ? 12.0 : 14.0;
    final titleToDescriptionGap = width < 720 ? 14.0 : 16.0;
    
    // Dynamic gap spacing: use wider breathing room when title & description are empty
    final contentGap = (title.isEmpty && description.isEmpty)
        ? (width < 720 ? 32.0 : 42.0)
        : (width < 720 ? 24.0 : 28.0);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: sectionVerticalPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RevealOnScroll(
                child: Text(
                  sectionLabel.toUpperCase(),
                  style: GoogleFonts.jetBrainsMono(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.8,
                  ),
                ),
              ),
              if (title.isNotEmpty) ...[
                SizedBox(height: headerToTitleGap),
                _RevealOnScroll(
                  delay: const Duration(milliseconds: 100),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Text(
                      title,
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                        fontSize:
                            MediaQuery.of(context).size.width < 720 ? 34 : 52,
                        fontWeight: FontWeight.w800,
                        height: 1.02,
                        letterSpacing: -1.8,
                      ),
                    ),
                  ),
                ),
              ],
              if (description.isNotEmpty) ...[
                SizedBox(height: titleToDescriptionGap),
                _RevealOnScroll(
                  delay: const Duration(milliseconds: 180),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 760),
                    child: Text(
                      description,
                      style: GoogleFonts.manrope(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
              SizedBox(height: contentGap),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return const _AboutCapabilities();
  }
}

class _AboutCapabilities extends StatelessWidget {
  const _AboutCapabilities();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth < 720
            ? constraints.maxWidth
            : (constraints.maxWidth - 16) / 2;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: capabilityItems.asMap().entries.map((entry) {
            return SizedBox(
              width: width,
              child: _RevealOnScroll(
                delay: Duration(milliseconds: 130 * (entry.key + 1)),
                child: _CapabilityCard(item: entry.value),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _CapabilityCard extends StatelessWidget {
  const _CapabilityCard({required this.item});

  final CapabilityItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        color: const Color(0xFF0A1121).withValues(alpha: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xFFA855F7),
                  Color(0xFF22D3EE),
                ],
              ),
            ),
            child: Icon(item.icon, color: Colors.white),
          ),
          const SizedBox(height: 14),
          Text(
            item.title,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: GoogleFonts.manrope(
              color: Colors.white70,
              fontSize: 14,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth < 800 ? constraints.maxWidth : 380.0;

        return Wrap(
          spacing: 18,
          runSpacing: 18,
          children: skillGroups.asMap().entries.map((entry) {
            return SizedBox(
              width: width,
              child: _RevealOnScroll(
                delay: Duration(milliseconds: 120 * (entry.key + 1)),
                child: _SkillGroupCard(group: entry.value),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _SkillGroupCard extends StatelessWidget {
  const _SkillGroupCard({required this.group});

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white.withValues(alpha: 0.03),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            group.title,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            group.caption,
            style: GoogleFonts.manrope(
              color: Colors.white70,
              fontSize: 15,
              height: 1.7,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: group.skills
                .map(
                  (String skill) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08)),
                      color: const Color(0xFF0E1528),
                    ),
                    child: Text(
                      skill,
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({Key? key, required this.onProjectTap})
      : super(key: key);

  final ValueChanged<String> onProjectTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final cardGap = constraints.maxWidth < 720 ? 16.0 : 24.0;
        final cardHeight = constraints.maxWidth < 720
            ? 470.0
            : constraints.maxWidth < 1180
                ? 490.0
                : 510.0;
        final cardWidth = constraints.maxWidth < 720
            ? constraints.maxWidth
            : constraints.maxWidth < 1180
                ? (constraints.maxWidth - cardGap) / 2
                : math.min((constraints.maxWidth - (cardGap * 2)) / 3, 390.0);

        return Wrap(
          spacing: cardGap,
          runSpacing: cardGap,
          children: portfolioProjects.asMap().entries.map((entry) {
            return SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: _ProjectCard(
                index: entry.key + 1,
                project: entry.value,
                onTap: () => onProjectTap(entry.value.projectUrl),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({
    required this.index,
    required this.project,
    required this.onTap,
  });

  final int index;
  final PortfolioProject project;
  final VoidCallback onTap;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            transform:
                Matrix4.translationValues(0.0, _isHovered ? -10.0 : 0.0, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0C1325).withValues(alpha: 0.96),
                  const Color(0xFF050814).withValues(alpha: 0.96),
                ],
              ),
              border: Border.all(
                color: _isHovered
                    ? const Color(0xFF22D3EE).withValues(alpha: 0.42)
                    : Colors.white.withValues(alpha: 0.08),
              ),
              boxShadow: <BoxShadow>[
                if (_isHovered)
                  BoxShadow(
                    color: const Color(0xFF22D3EE).withValues(alpha: 0.14),
                    blurRadius: 38,
                    offset: const Offset(0, 22),
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          widget.project.imageAsset,
                          fit: BoxFit.cover,
                          cacheWidth: kIsWeb ? 960 : null,
                          cacheHeight: kIsWeb ? 720 : null,
                          filterQuality:
                              kIsWeb ? FilterQuality.low : FilterQuality.medium,
                          errorBuilder: (
                            BuildContext context,
                            Object error,
                            StackTrace? stackTrace,
                          ) {
                            return Container(
                              color: const Color(0xFF0B1220),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.broken_image_outlined,
                                color: Colors.white38,
                                size: 38,
                              ),
                            );
                          },
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.black.withValues(alpha: 0.1),
                                Colors.black.withValues(alpha: 0.28),
                                Colors.black.withValues(alpha: 0.88),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 18,
                          left: 18,
                          right: 18,
                          child: Row(
                            children: [
                              _ProjectMetaChip(
                                label: widget.index.toString().padLeft(2, '0'),
                                highlighted: true,
                              ),
                              const Spacer(),
                              _ProjectMetaChip(
                                label: widget.project.tags.first,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 22,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.project.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.spaceGrotesk(
                                  color: Colors.white,
                                  fontSize: 28,
                                  height: 1.02,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.8,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.project.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.manrope(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  height: 1.6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.project.tags
                              .map(
                                (String tag) => _ProjectMetaChip(label: tag),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Text(
                              'View repository',
                              style: GoogleFonts.spaceGrotesk(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              width: _isHovered ? 58 : 40,
                              height: 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color(0xFFA855F7),
                                    Color(0xFF22D3EE),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              transform: Matrix4.translationValues(
                                _isHovered ? 6.0 : 0.0,
                                0.0,
                                0.0,
                              ),
                              child: const Icon(
                                Icons.north_east_rounded,
                                color: Color(0xFF22D3EE),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectMetaChip extends StatelessWidget {
  const _ProjectMetaChip({
    required this.label,
    this.highlighted = false,
  });

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: highlighted
            ? const Color(0xFFA855F7).withValues(alpha: 0.18)
            : Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: highlighted
              ? const Color(0xFFA855F7).withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          color: highlighted ? Colors.white : Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: experienceEntries.asMap().entries.map((entry) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: entry.key == experienceEntries.length - 1 ? 0 : 20,
          ),
          child: _RevealOnScroll(
            delay: Duration(milliseconds: 150 * (entry.key + 1)),
            child: _ExperienceCard(
              entry: entry.value,
              index: entry.key + 1,
              showConnector: entry.key != experienceEntries.length - 1,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.entry,
    required this.index,
    required this.showConnector,
  });

  final ExperienceEntry entry;
  final int index;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    final isCurrentRole = entry.period.toLowerCase().contains('present');

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isCompact = constraints.maxWidth < 760;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 34,
              child: Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFFA855F7),
                          Color(0xFF22D3EE),
                        ],
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color:
                              const Color(0xFFA855F7).withValues(alpha: 0.22),
                          blurRadius: 18,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  if (showConnector)
                    Container(
                      width: 2,
                      height: isCompact ? 178 : 166,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(isCompact ? 20 : 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                      color: const Color(0xFF091120).withValues(alpha: 0.9),
                    ),
                    child: isCompact
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _ExperienceAvatar(entry: entry),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          entry.company,
                                          style: GoogleFonts.spaceGrotesk(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        _ExperienceInfoPill(
                                          label: entry.period,
                                          color: const Color(0xFFD8B4FE),
                                          background: const Color(0xFFA855F7)
                                              .withValues(alpha: 0.1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Text(
                                entry.role,
                                style: GoogleFonts.spaceGrotesk(
                                  color: Colors.white,
                                  fontSize: 25,
                                  height: 1.05,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 14),
                              if (isCurrentRole) ...[
                                _ExperienceInfoPill(
                                  label: 'Current role',
                                  color: const Color(0xFF67E8F9),
                                  background: const Color(0xFF22D3EE)
                                      .withValues(alpha: 0.12),
                                ),
                                const SizedBox(height: 16),
                              ],
                              Text(
                                entry.description,
                                style: GoogleFonts.manrope(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  height: 1.75,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _ExperienceAvatar(entry: entry),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                entry.company,
                                                style: GoogleFonts.spaceGrotesk(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              _ExperienceInfoPill(
                                                label: entry.period,
                                                color: const Color(0xFFD8B4FE),
                                                background:
                                                    const Color(0xFFA855F7)
                                                        .withValues(alpha: 0.1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isCurrentRole) ...[
                                      const SizedBox(height: 16),
                                      _ExperienceInfoPill(
                                        label: 'Current role',
                                        color: const Color(0xFF67E8F9),
                                        background: const Color(0xFF22D3EE)
                                            .withValues(alpha: 0.12),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 28),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.role,
                                      style: GoogleFonts.spaceGrotesk(
                                        color: Colors.white,
                                        fontSize: 30,
                                        height: 1.02,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.8,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      entry.description,
                                      style: GoogleFonts.manrope(
                                        color: Colors.white70,
                                        fontSize: 15,
                                        height: 1.8,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 18,
                    child: Text(
                      index.toString().padLeft(2, '0'),
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white.withValues(alpha: 0.06),
                        fontSize: 56,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ExperienceInfoPill extends StatelessWidget {
  const _ExperienceInfoPill({
    required this.label,
    required this.color,
    required this.background,
  });

  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: background,
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ExperienceAvatar extends StatelessWidget {
  const _ExperienceAvatar({required this.entry});

  final ExperienceEntry entry;

  @override
  Widget build(BuildContext context) {
    if (entry.logoAsset != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          entry.logoAsset!,
          width: 68,
          height: 68,
          fit: BoxFit.cover,
          cacheWidth: kIsWeb ? 136 : null,
          cacheHeight: kIsWeb ? 136 : null,
          filterQuality: kIsWeb ? FilterQuality.low : FilterQuality.medium,
          errorBuilder: (
            BuildContext context,
            Object error,
            StackTrace? stackTrace,
          ) {
            return Container(
              width: 68,
              height: 68,
              color: const Color(0xFF0B1220),
              alignment: Alignment.center,
              child: Text(
                entry.company.substring(0, 1).toUpperCase(),
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white70,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        ),
      );
    }

    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xFFA855F7),
            Color(0xFF22D3EE),
          ],
        ),
      ),
      child: const Icon(
        Icons.business_center_rounded,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class _ContactSection extends StatefulWidget {
  const _ContactSection({
    required this.onGithubTap,
    required this.onLinkedInTap,
  });

  final VoidCallback onGithubTap;
  final VoidCallback onLinkedInTap;

  @override
  State<_ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<_ContactSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your email';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your message';
    }
    if (value.trim().length < 10) {
      return 'Message is too short';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true || _isSending) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: <String, String>{
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode(
          <String, dynamic>{
            'service_id': emailJsServiceId,
            'template_id': emailJsTemplateId,
            'user_id': emailJsUserId,
            'template_params': <String, String>{
              'name': _nameController.text.trim(),
              'subject': 'Portfolio website enquiry',
              'message': _messageController.text.trim(),
              'user_email': _emailController.text.trim(),
            },
          },
        ),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _isSending = false;
      });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message sent successfully.')),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Unable to send right now. Please try again.')),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSending = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to connect right now. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 980;

    return Container(
      padding: EdgeInsets.all(isCompact ? 22 : 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.06),
            const Color(0xFFA855F7).withValues(alpha: 0.07),
            const Color(0xFF22D3EE).withValues(alpha: 0.06),
          ],
        ),
      ),
      child: isCompact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ContactFormCard(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  messageController: _messageController,
                  isSending: _isSending,
                  onSubmit: _submit,
                  validateName: _validateName,
                  validateEmail: _validateEmail,
                  validateMessage: _validateMessage,
                ),
                const SizedBox(height: 24),
                _ContactSummaryCard(
                  onGithubTap: widget.onGithubTap,
                  onLinkedInTap: widget.onLinkedInTap,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 11,
                  child: _ContactFormCard(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    messageController: _messageController,
                    isSending: _isSending,
                    onSubmit: _submit,
                    validateName: _validateName,
                    validateEmail: _validateEmail,
                    validateMessage: _validateMessage,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 8,
                  child: _ContactSummaryCard(
                    onGithubTap: widget.onGithubTap,
                    onLinkedInTap: widget.onLinkedInTap,
                  ),
                ),
              ],
            ),
    );
  }
}

class _ContactFormCard extends StatelessWidget {
  const _ContactFormCard({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.isSending,
    required this.onSubmit,
    required this.validateName,
    required this.validateEmail,
    required this.validateMessage,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  final bool isSending;
  final VoidCallback onSubmit;
  final String? Function(String?) validateName;
  final String? Function(String?) validateEmail;
  final String? Function(String?) validateMessage;

  @override
  Widget build(BuildContext context) {
    return _RevealOnScroll(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final stackFields = constraints.maxWidth < 620;
          final stackFooter = constraints.maxWidth < 520;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let\'s connect with a proper message flow.',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 30,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.2,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Share your name, email, and message below. The form stays visible, responsive, and sends directly from the portfolio.',
                style: GoogleFonts.manrope(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    if (stackFields)
                      Column(
                        children: [
                          _ContactField(
                            controller: nameController,
                            hintText: 'Your name',
                            validator: validateName,
                          ),
                          const SizedBox(height: 14),
                          _ContactField(
                            controller: emailController,
                            hintText: 'Your email',
                            validator: validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: _ContactField(
                              controller: nameController,
                              hintText: 'Your name',
                              validator: validateName,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _ContactField(
                              controller: emailController,
                              hintText: 'Your email',
                              validator: validateEmail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 14),
                    _ContactField(
                      controller: messageController,
                      hintText: 'Tell me about your project',
                      validator: validateMessage,
                      maxLines: 6,
                    ),
                    const SizedBox(height: 18),
                    if (stackFooter)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Powered by a direct portfolio contact flow.',
                            style: GoogleFonts.jetBrainsMono(
                              color: Colors.white38,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 14),
                          _ActionButton(
                            label: isSending ? 'Sending...' : 'Send Message',
                            onTap: onSubmit,
                            filled: true,
                            enabled: !isSending,
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Powered by a direct portfolio contact flow.',
                              style: GoogleFonts.jetBrainsMono(
                                color: Colors.white38,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          _ActionButton(
                            label: isSending ? 'Sending...' : 'Send Message',
                            onTap: onSubmit,
                            filled: true,
                            enabled: !isSending,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ContactField extends StatelessWidget {
  const _ContactField({
    required this.controller,
    required this.hintText,
    required this.validator,
    this.maxLines = 1,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.manrope(
          color: Colors.white38,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.04),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF22D3EE)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}

class _ContactSummaryCard extends StatelessWidget {
  const _ContactSummaryCard({
    required this.onGithubTap,
    required this.onLinkedInTap,
  });

  final VoidCallback onGithubTap;
  final VoidCallback onLinkedInTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RevealOnScroll(
          delay: const Duration(milliseconds: 160),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: const Color(0xFF08101E).withValues(alpha: 0.88),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick connect',
                  style: GoogleFonts.jetBrainsMono(
                    color: const Color(0xFF22D3EE),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Use the form or jump to the platforms where I respond fastest.',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _ActionButton(
                      label: 'Open LinkedIn',
                      onTap: onLinkedInTap,
                      filled: true,
                    ),
                    _ActionButton(
                      label: 'Open GitHub',
                      onTap: onGithubTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
     
      
      ],
    );
  }
}



class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).size.width < 860;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 34),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1220),
          child: isCompact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '(c) 2026 $portfolioName. Built with Flutter for a smoother portfolio experience.',
                      style: GoogleFonts.manrope(
                        color: Colors.white54,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Design direction inspired by the shared reference site',
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white38,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Text(
                        '(c) 2026 $portfolioName. Built with Flutter for a smoother portfolio experience.',
                        style: GoogleFonts.manrope(
                          color: Colors.white54,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Design direction inspired by the shared reference site',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white38,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _LoaderOverlay extends StatelessWidget {
  const _LoaderOverlay({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        final progress = (controller.value * 100).clamp(0.0, 100.0);

        return ColoredBox(
          color: Colors.black,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0.0, -0.35),
                      radius: 1.2,
                      colors: [
                        const Color(0xFFA855F7).withValues(alpha: 0.16),
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'AKSHAY',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white38,
                        fontSize: 44,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${progress.round()}',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white,
                        fontSize: 108,
                        fontWeight: FontWeight.w800,
                        height: 0.9,
                      ),
                    ),
                    Text(
                      '%',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFFA855F7),
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: 280,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          minHeight: 4,
                          value: controller.value,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFA855F7),
                          ),
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Rendering smooth portfolio experience...',
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 34,
                left: 34,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 1,
                      color: const Color(0xFFA855F7).withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'STATUS: ONLINE',
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white24,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onTap,
    this.filled = false,
    this.enabled = true,
  });

  final String label;
  final VoidCallback onTap;
  final bool filled;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1 : 0.58,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: filled
                ? const LinearGradient(
                    colors: <Color>[
                      Color(0xFFA855F7),
                      Color(0xFF22D3EE),
                    ],
                  )
                : null,
            color: filled ? null : Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: filled
                  ? Colors.transparent
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.north_east_rounded,
                size: 18,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RevealOnScroll extends StatefulWidget {
  const _RevealOnScroll({
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  State<_RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<_RevealOnScroll> {
  bool _revealed = false;
  bool _revealScheduled = false;
  late final Key _visibilityKey = UniqueKey();
  Timer? _revealTimer;

  @override
  void dispose() {
    _revealTimer?.cancel();
    super.dispose();
  }

  void _reveal() {
    if (_revealed || _revealScheduled) {
      return;
    }

    _revealScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      void revealNow() {
        if (!mounted || _revealed) {
          return;
        }

        setState(() {
          _revealed = true;
        });
      }

      if (widget.delay == Duration.zero) {
        revealNow();
        return;
      }

      _revealTimer = Timer(widget.delay, revealNow);
    });
  }

  @override
  Widget build(BuildContext context) {
    final useStaticReveal =
        kIsWeb || MediaQuery.maybeOf(context)?.disableAnimations == true;
    if (useStaticReveal) {
      return widget.child;
    }

    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.1) {
          _reveal();
        }
      },
      child: AnimatedOpacity(
        opacity: _revealed ? 1 : 0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          transform:
              Matrix4.translationValues(0.0, _revealed ? 0.0 : 28.0, 0.0),
          child: widget.child,
        ),
      ),
    );
  }
}
