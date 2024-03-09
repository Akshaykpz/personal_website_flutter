// import 'package:flutter/material.dart';
// import 'package:my_personal_website/constants/colors.dart';
// import 'package:my_personal_website/constants/textstyle.dart';
// import 'package:my_personal_website/view/screens/home.dart';
// import 'package:my_personal_website/view/screens/skills.dart';
// import 'package:my_personal_website/view/screens/contact_us.dart';
// import 'package:my_personal_website/view/screens/experience.dart';
// import 'package:my_personal_website/view/screens/footer_class.dart';
// import 'package:my_personal_website/view/screens/my_projects.dart';
// import 'package:my_personal_website/view/screens/my_service.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({Key? key}) : super(key: key);

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   final ItemScrollController _itemScrollController = ItemScrollController();
//   final ItemPositionsListener itemPositionsListener =
//       ItemPositionsListener.create();
//   final ScrollOffsetListener scrollOffsetListener =
//       ScrollOffsetListener.create();
//   final onmenuHover = Matrix4.identity()..scale(1.0);
//   final menuitem = <String>[
//     'About',
//     'Skills',
//     'Experience',
//     'Service',
//     'Projects',
//     'Contacts',
//   ];

//   final screenlist = <Widget>[
//     Homepage(),
//     const AboutMe(),
//     const Expierence(),
//     const MyService(),
//     const MyPortfolio(),
//     const ContactMe(),
//     const FotterClass(),
//   ];
//   final Color backgroundColor = const Color.fromARGB(255, 13, 16, 28);
//   final Color buttonColor = Colors.blue;
//   var menuIndex = 0;
//   Future scrollTo({required int index}) async {
//     _itemScrollController
//         .scrollTo(
//             index: index,
//             duration: const Duration(seconds: 2),
//             curve: Curves.fastLinearToSlowEaseIn)
//         .whenComplete(() {
//       setState(() {
//         menuIndex = index;
//       });
//     });
//   }

//   final yourScrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           titleSpacing: 100,
//           toolbarHeight: 90,
//           backgroundColor: Colors.transparent,
//           elevation: 4,
//           title: LayoutBuilder(
//             builder: (context, constraints) {
//               if (constraints.maxWidth < 768) {
//                 return Stack(
//                   children: [
//                     PopupMenuButton(
//                       color: AppColors.bgcolors,
//                       position: PopupMenuPosition.under,
//                       constraints:
//                           BoxConstraints.tightFor(width: size.width * 0.9),
//                       itemBuilder: (context) {
//                         return menuitem
//                             .asMap()
//                             .entries
//                             .map((e) => PopupMenuItem(
//                                   child: Text(
//                                     e.value,
//                                     style: const TextStyle(color: Colors.white),
//                                   ),
//                                   onTap: () {
//                                     scrollTo(index: e.key);
//                                   },
//                                 ))
//                             .toList();
//                       },
//                       icon: const Icon(
//                         Icons.menu_sharp,
//                         color: Colors.white,
//                       ),
//                     ),
//                     Positioned(
//                       left: 48, // Adjust this value as needed
//                       child: Text(
//                         'Portfolio',
//                         style: Apptext.biodatas(),
//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 return Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Portfolio',
//                         style: Apptext.biodatas(),
//                       ),
//                       const Spacer(),
//                       SizedBox(
//                         height: 40,
//                         child: ListView.separated(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) => const SizedBox(
//                                   width: 3,
//                                 ),
//                             separatorBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   scrollTo(index: index);
//                                 },
//                                 borderRadius: BorderRadius.circular(100),
//                                 onHover: (value) {
//                                   setState(() {
//                                     if (value) {
//                                       menuIndex = index;
//                                     } else {
//                                       menuIndex = 0;
//                                     }
//                                   });
//                                 },
//                                 child: animatedContainer(
//                                     index, menuIndex == index ? true : false),
//                               );
//                             },
//                             itemCount: menuitem.length),
//                       ),
//                     ]);
//               }
//             },
//           ),
//         ),
//         body: Scrollbar(
//           trackVisibility: true,
//           thumbVisibility: true,
//           thickness: 8,
//           interactive: true,
//           controller: yourScrollController,
//           child: ScrollablePositionedList.builder(
//             itemCount: screenlist.length,
//             itemScrollController: _itemScrollController,
//             itemPositionsListener: itemPositionsListener,
//             scrollOffsetListener: scrollOffsetListener,
//             itemBuilder: (context, index) {
//               return screenlist[index];
//             },
//           ),
//         ));
//   }

//   AnimatedContainer animatedContainer(int index, bool hover) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       alignment: Alignment.center,
//       width: hover ? 90 : 85,
//       transform: hover ? onmenuHover : null,
//       child: Text(menuitem[index],
//           style: Apptext.headertextstyle(
//             hover ? Colors.blue : Colors.white,
//           )),
//     );
//   }
// }
import 'package:flutter/material.dart';
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
            duration: const Duration(seconds: 2),
            curve: Curves.fastLinearToSlowEaseIn)
        .whenComplete(() {
      setState(() {
        menuIndex = index;
      });
    });
  }

  final ScrollController yourScrollController =
      ScrollController(); // Changed here
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 100,
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        elevation: 4,
        title: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 768) {
              return Stack(
                children: [
                  PopupMenuButton(
                    color: AppColors.bgcolors,
                    position: PopupMenuPosition.under,
                    constraints:
                        BoxConstraints.tightFor(width: size.width * 0.9),
                    itemBuilder: (context) {
                      return menuitem
                          .asMap()
                          .entries
                          .map((e) => PopupMenuItem(
                                child: Text(
                                  e.value,
                                  style: const TextStyle(color: Colors.white),
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
                  Positioned(
                    left: 48, // Adjust this value as needed
                    child: Text(
                      'Portfolio',
                      style: Apptext.biodatas(),
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
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => const SizedBox(
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
                          child: animatedContainer(
                              index, menuIndex == index ? true : false),
                        );
                      },
                      itemCount: menuitem.length,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      body: Scrollbar(
        trackVisibility: true,
        thumbVisibility: true,
        thickness: 8,
        interactive: true,
        controller: yourScrollController,
        child: SingleChildScrollView(
          // Changed here
          controller: yourScrollController,
          child: Column(
            // Added here
            children: [
              for (var widget in screenlist) widget,
            ],
          ),
        ),
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
            hover ? Colors.blue : Colors.white,
          )),
    );
  }
}
