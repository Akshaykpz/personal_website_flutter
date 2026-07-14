import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/animations.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/view/screens/contact_us.dart';
import 'package:my_personal_website/view/screens/experience.dart';
import 'package:my_personal_website/view/screens/footer_class.dart';
import 'package:my_personal_website/view/screens/home.dart';
import 'package:my_personal_website/view/screens/my_projects.dart';
import 'package:my_personal_website/view/screens/my_service.dart';
import 'package:my_personal_website/view/screens/skills.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final ValueNotifier<Offset> _mousePosition = ValueNotifier<Offset>(Offset.zero);
  final ValueNotifier<bool> _showCursor = ValueNotifier<bool>(false);
  int? _hoveredMenuIndex;
  int menuIndex = 0;

  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  final menuitem = <String>[
    'About',
    'Skills',
    'Experience',
    'Service',
    'Projects',
    'Contacts',
  ];

  late final screenlist = <Widget>[
    Homepage(),
    const AboutMe(),
    const Expierence(),
    const MyService(),
    const MyPortfolio(),
    const ContactMe(),
    const FotterClass(),
  ];

  @override
  void initState() {
    super.initState();
    itemPositionsListener.itemPositions.addListener(_syncActiveSection);
  }

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(_syncActiveSection);
    _mousePosition.dispose();
    _showCursor.dispose();
    super.dispose();
  }

  void _syncActiveSection() {
    final positions = itemPositionsListener.itemPositions.value
        .where((position) => position.itemTrailingEdge > 0)
        .toList()
        ..sort((a, b) => a.itemLeadingEdge.compareTo(b.itemLeadingEdge));
    if (positions.isEmpty) return;

    final nextIndex = positions.first.index.clamp(0, menuitem.length - 1);
    if (nextIndex != menuIndex && mounted) {
      setState(() {
        menuIndex = nextIndex;
      });
    }
  }

  Future<void> scrollTo({required int index}) async {
    await _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOutCubic,
    );
    if (mounted) {
      setState(() {
        menuIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: (_) => _showCursor.value = true,
      onExit: (_) => _showCursor.value = false,
      onHover: (event) => _mousePosition.value = event.position,
      child: Stack(
        children: [
          const Positioned.fill(child: AnimatedTechBackground()),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ScrollConfiguration(
              behavior: const PortfolioScrollBehavior(),
              child: ScrollablePositionedList.builder(
                scrollOffsetController: scrollOffsetController,
                scrollDirection: Axis.vertical,
                itemCount: screenlist.length,
                itemScrollController: _itemScrollController,
                itemPositionsListener: itemPositionsListener,
                scrollOffsetListener: scrollOffsetListener,
                physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemBuilder: (context, index) {
                  return screenlist[index];
                },
              ),
            ),
          ),
          Positioned(
            top: size.width < 600 ? 8 : 12,
            left: 12,
            right: 12,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1440),
                child: _Header(
                  menuitem: menuitem,
                  menuIndex: menuIndex,
                  hoveredMenuIndex: _hoveredMenuIndex,
                  onHover: (index) => setState(() {
                    _hoveredMenuIndex = index;
                  }),
                  onExit: () => setState(() {
                    _hoveredMenuIndex = null;
                  }),
                  onSelect: (index) => scrollTo(index: index),
                ),
              ),
            ),
          ),
          _CustomCursor(
            positionNotifier: _mousePosition,
            showNotifier: _showCursor,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final List<String> menuitem;
  final int menuIndex;
  final int? hoveredMenuIndex;
  final ValueChanged<int?> onHover;
  final VoidCallback onExit;
  final ValueChanged<int> onSelect;

  const _Header({
    required this.menuitem,
    required this.menuIndex,
    required this.hoveredMenuIndex,
    required this.onHover,
    required this.onExit,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            height: MediaQuery.of(context).size.width < 550 ? 56 : 72,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width < 550 ? 16 : 32,
            ),
            decoration: BoxDecoration(
              color: AppColors.opacity48,
              border: Border.all(color: AppColors.slate900, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 900;
                return Row(
                  children: [
                    _Logo(),
                    const Spacer(),
                    if (isCompact)
                      PopupMenuButton<int>(
                        color: AppColors.slate950,
                        position: PopupMenuPosition.under,
                        onSelected: onSelect,
                        itemBuilder: (context) {
                          return menuitem
                              .asMap()
                              .entries
                              .map(
                                (entry) => PopupMenuItem<int>(
                                  value: entry.key,
                                  child: Text(
                                    entry.value,
                                    style: Apptext.headertextstyle(
                                      AppColors.slateWhite,
                                    ),
                                  ),
                                ),
                              )
                              .toList();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.slateWhite,
                        ),
                      )
                    else
                      Row(
                        children: menuitem.asMap().entries.map((entry) {
                          final isActive = menuIndex == entry.key;
                          final isHovered = hoveredMenuIndex == entry.key;
                          return _HeaderLink(
                            text: entry.value,
                            isActive: isActive,
                            isHovered: isHovered,
                            onTap: () => onSelect(entry.key),
                            onEnter: () => onHover(entry.key),
                            onExit: onExit,
                          );
                        }).toList(),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.slate800),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.turquoise300,
                AppColors.pink300,
                AppColors.violet500,
              ],
            ),
          ),
          child: Center(
            child: Text(
              'A',
              style: Apptext.buttonText(AppColors.slateBlack),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text('AKSHAY KP', style: Apptext.biodatas()),
      ],
    );
  }
}

class _HeaderLink extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isHovered;
  final VoidCallback onTap;
  final VoidCallback onEnter;
  final VoidCallback onExit;

  const _HeaderLink({
    required this.text,
    required this.isActive,
    required this.isHovered,
    required this.onTap,
    required this.onEnter,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final active = isActive || isHovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onEnter(),
      onExit: (_) => onExit(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          width: 92,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 220),
                style: Apptext.headertextstyle(
                  active ? AppColors.slateWhite : AppColors.slate200,
                ),
                child: Text(text),
              ),
              Positioned(
                bottom: 2,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  width: active ? 44 : 0,
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.turquoise300.withOpacity(0.9),
                        Colors.transparent,
                      ],
                    ),
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

class PortfolioScrollBehavior extends MaterialScrollBehavior {
  const PortfolioScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class _CustomCursor extends StatelessWidget {
  final ValueNotifier<Offset> positionNotifier;
  final ValueNotifier<bool> showNotifier;

  const _CustomCursor({
    Key? key,
    required this.positionNotifier,
    required this.showNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showNotifier,
      builder: (context, show, child) {
        if (!show) return const SizedBox.shrink();
        return ValueListenableBuilder<Offset>(
          valueListenable: positionNotifier,
          builder: (context, position, child) {
            return Positioned(
              left: position.dx - 12,
              top: position.dy - 12,
              child: IgnorePointer(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.turquoise300.withOpacity(0.08),
                    border: Border.all(
                      color: AppColors.turquoise300.withOpacity(0.7),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.turquoise300.withOpacity(0.12),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
