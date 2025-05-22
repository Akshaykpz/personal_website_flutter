import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/view/screens/home.dart';
import 'package:my_personal_website/view/screens/skills.dart';
import 'package:my_personal_website/view/screens/contact_us.dart';
import 'package:my_personal_website/view/screens/experience.dart';
import 'package:my_personal_website/view/screens/footer_class.dart';
import 'package:my_personal_website/view/screens/my_projects.dart';
import 'package:my_personal_website/view/screens/my_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Offset _mousePosition = Offset.zero;
  double _bubbleSize = 10.0;

  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  final onmenuHover = Matrix4.identity()..scale(1.0);
  final menuitem = <String>[
    'About',
    'Skills',
    'Experience',
    'Service',
    'Projects',
    'Contacts',
  ];

  final screenlist = <Widget>[
    Homepage(),
    const AboutMe(),
    const Expierence(),
    const MyService(),
    const MyPortfolio(),
    const ContactMe(),
    const FotterClass(),
  ];
  final Color backgroundColor = const Color.fromARGB(255, 13, 16, 28);
  final Color buttonColor = Colors.blue;
  var menuIndex = 0;
  Future scrollTo({required int index}) async {
    _itemScrollController
        .scrollTo(
            index: index,
            duration: const Duration(seconds: 1),
            curve: Curves.ease)
        .whenComplete(() {
      setState(() {
        menuIndex = index;
      });
    });
  }

  final yourScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onHover: (event) {
        setState(() {
          _mousePosition = event.position;
          _bubbleSize = 40.0;
        });

        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _bubbleSize = 20.0;
            });
          }
        });
      },
      child: Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                titleSpacing: 55,
                toolbarHeight: 90,
                backgroundColor: Colors.transparent,
                elevation: 0.1,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.white),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.ebony, AppColors.studio],
                    ),
                  ),
                ),
                title: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 768) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Portfolio',
                            style: Apptext.biodatas(),
                          ),
                          const Spacer(),
                          PopupMenuButton(
                            color: AppColors.bgcolors,
                            position: PopupMenuPosition.under,
                            constraints: BoxConstraints.tightFor(
                                width: size.width * 0.8),
                            itemBuilder: (context) {
                              return menuitem
                                  .asMap()
                                  .entries
                                  .map((e) => PopupMenuItem(
                                        child: Text(
                                          e.value,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        onTap: () {
                                          scrollTo(index: e.key);
                                        },
                                      ))
                                  .toList();
                            },
                            icon: const Icon(
                              Icons.menu_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Portfolio',
                              style: Apptext.biodatas(),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 40,
                              child: ListView.separated(
                                  controller: yourScrollController,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 3,
                                      ),
                                  separatorBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        scrollTo(index: index);
                                      },
                                      borderRadius: BorderRadius.circular(100),
                                      onHover: (value) {
                                        setState(() {
                                          if (value) {
                                            menuIndex = index;
                                          } else {
                                            menuIndex = 0;
                                          }
                                        });
                                      },
                                      child: animatedContainer(index,
                                          menuIndex == index ? true : false),
                                    );
                                  },
                                  itemCount: menuitem.length),
                            ),
                          ]);
                    }
                  },
                ),
              ),
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.ebony,
                      AppColors.studio
                    ], // Your mixed colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Scrollbar(
                  trackVisibility: true,
                  thumbVisibility: true,
                  thickness: 8,
                  interactive: true,
                  controller: yourScrollController,
                  child: ScrollablePositionedList.builder(
                    scrollOffsetController: scrollOffsetController,
                    scrollDirection: Axis.vertical,
                    itemCount: screenlist.length,
                    itemScrollController: _itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    scrollOffsetListener: scrollOffsetListener,
                    itemBuilder: (context, index) {
                      return screenlist[index];
                    },
                  ),
                ),
              )),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 20),
            left: _mousePosition.dx - _bubbleSize / 2 - 1,
            top: _mousePosition.dy - _bubbleSize / 2 - 1,
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _bubbleSize,
                height: _bubbleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.studio,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.studio,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                  border: Border.all(
                    color: const Color.fromARGB(255, 254, 254, 254),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer animatedContainer(int index, bool hover) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.center,
      width: hover ? 90 : 85,
      transform: hover ? onmenuHover : null,
      child: Text(menuitem[index],
          style: Apptext.headertextstyle(
            hover ? const Color.fromARGB(255, 172, 139, 255) : Colors.white,
          )),
    );
  }
}
