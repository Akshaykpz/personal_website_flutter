// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:my_personal_website/constants/colors.dart';
// import 'package:my_personal_website/constants/image.dart';
// import 'package:my_personal_website/constants/text.dart';
// import 'package:my_personal_website/constants/textstyle.dart';
// import 'package:my_personal_website/helper/helper_class.dart';

// class MyPortfolio extends StatefulWidget {
//   const MyPortfolio({Key? key}) : super(key: key);

//   @override
//   State<MyPortfolio> createState() => _MyPortfolioState();
// }

// class _MyPortfolioState extends State<MyPortfolio> {
//   int? hoveredIndex;

//   final List<String> appset = [
//     AppImage.project1,
//     AppImage.project2,
//     AppImage.wheather,
//     AppImage.netflix,
//     AppImage.music,
//     AppImage.taskManger
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return HelperClass(
//       mobile: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _fadeDowntext(),
//           const SizedBox(height: 40),
//           buildProjectGridView(crossAxisCount: 1)
//         ],
//       ),
//       tablet: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _fadeDowntext(),
//           const SizedBox(height: 40),
//           buildProjectGridView(crossAxisCount: 2)
//         ],
//       ),
//       desktop: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _fadeDowntext(),
//           const SizedBox(height: 40),
//           buildProjectGridView(crossAxisCount: 3),
//         ],
//       ),
//       paddingWidth: size.width * 0.1,
//       bgColor: AppColors.bgcolors,
//     );
//   }

//   GridView buildProjectGridView({required int crossAxisCount}) {
//     return GridView.builder(
//       itemCount: appset.length,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount,
//         mainAxisExtent: 280,
//         mainAxisSpacing: 24,
//         crossAxisSpacing: 24,
//       ),
//       itemBuilder: (context, index) {
//         var image = appset[index];

//         return FadeInUpBig(
//           duration: const Duration(milliseconds: 1600),
//           child: InkWell(
//             onTap: () {},
//             onHover: (value) {
//               setState(() {
//                 hoveredIndex = value ? index : 0;
//               });
//             },
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 600),
//                   curve: Curves.easeInOut,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                       image: AssetImage(image),
//                       fit: BoxFit.fill,
//                       colorFilter: hoveredIndex == index
//                           ? ColorFilter.mode(
//                               Colors.black.withOpacity(0.4), BlendMode.darken)
//                           : null,
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: hoveredIndex == index,
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 600),
//                     curve: Curves.easeInOut,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 14, vertical: 16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       gradient: LinearGradient(
//                         colors: hoveredIndex == index
//                             ? [
//                                 Colors.white.withOpacity(0.1),
//                                 AppColors.studio,
//                               ]
//                             : [
//                                 Colors.transparent,
//                                 Colors.transparent,
//                               ],
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           projects[index],
//                           style: AppTextStyles.montserratStyle(
//                               color: Colors.orange, fontSize: 20),
//                         ),
//                         const SizedBox(height: 15),
//                         Text(
//                           projectContent[index],
//                           style: AppTextStyles.normalStyle(color: Colors.black),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 10),
//                         GestureDetector(
//                           onTap: () {},
//                           child: CircleAvatar(
//                             maxRadius: 25,
//                             backgroundColor: Colors.white,
//                             child: Image.asset(
//                               AppImage.shere,
//                               width: 25,
//                               height: 25,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _fadeDowntext() {
//     return FadeInDown(
//       child: RichText(
//         text: TextSpan(
//           text: 'Latest',
//           style: Apptext.addstyles(Colors.white),
//           children: [
//             TextSpan(
//               text: '  projects',
//               style: Apptext.addstyles(Colors.white),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/text.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';
import 'package:my_personal_website/helper/project_proivder.dart';
import 'package:provider/provider.dart';

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<HoverNotifier>(
      builder: (context, hoverNotifier, child) {
        final int? hoveredIndex = hoverNotifier.hoveredIndex;

        return HelperClass(
          mobile: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _fadeDowntext(),
              const SizedBox(height: 40),
              buildProjectGridView(
                  crossAxisCount: 1,
                  hoveredIndex: hoveredIndex,
                  hoverNotifier: hoverNotifier)
            ],
          ),
          tablet: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _fadeDowntext(),
              const SizedBox(height: 40),
              buildProjectGridView(
                  crossAxisCount: 2,
                  hoveredIndex: hoveredIndex,
                  hoverNotifier: hoverNotifier)
            ],
          ),
          desktop: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _fadeDowntext(),
              const SizedBox(height: 40),
              buildProjectGridView(
                  crossAxisCount: 3,
                  hoveredIndex: hoveredIndex,
                  hoverNotifier: hoverNotifier),
            ],
          ),
          paddingWidth: size.width * 0.1,
          bgColor: AppColors.bgcolors,
        );
      },
    );
  }

  GridView buildProjectGridView({
    required int crossAxisCount,
    required int? hoveredIndex,
    required HoverNotifier hoverNotifier,
  }) {
    final List<String> appset = [
      AppImage.project1,
      AppImage.project2,
      AppImage.wheather,
      AppImage.netflix,
      AppImage.music,
      AppImage.taskManger
    ];

    final List<String> projects = [
      'Acqa Med Tracker',
      'StoreX',
      'Wheather-App',
      'Netflix',
      'Music-App',
      'TaskManger'
    ];
    final List<String> projectContent = [
      'Implemented features for tracking medication schedules, reminding users to take their medicines on time.Integrated a water intake tracker',
      'Developed an e-commerce platform that allows users to browse, purchase, The app integrates features like real-time database updates, secure payments,.',
      'Developed a weather tracking app that provides real-time weather updates, forecasts, and other location-based weather details. The app uses a weather API to fetch live weather',
      'Developed a movie streaming app inspired by Netflix .The app pulls data from the TMDb API (The Movie Database) to provide an extensive collection of media content.',
      'Developed a music player app that allows users to listen to their local music library,. The app focuses on providing a seamless offline experience for music lovers.',
      'Developed a Task Manager application to help users manage their tasks, The app features task creation, backend built in Node.js and TypeScript, and a PostgreSQL database for storing task data'
    ];

    return GridView.builder(
      itemCount: appset.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 280,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        var image = appset[index];

        return FadeInUpBig(
          duration: const Duration(milliseconds: 1600),
          child: InkWell(
            onTap: () {},
            onHover: (value) {
              hoverNotifier.setHoveredIndex(value ? index : null);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                      colorFilter: hoveredIndex == index
                          ? ColorFilter.mode(
                              Colors.black.withOpacity(0.4), BlendMode.darken)
                          : null,
                    ),
                  ),
                ),
                Visibility(
                  visible: hoveredIndex == index,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: hoveredIndex == index
                            ? [
                                Colors.white.withOpacity(0.1),
                                AppColors.studio,
                              ]
                            : [
                                Colors.transparent,
                                Colors.transparent,
                              ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          projects[index],
                          style: AppTextStyles.montserratStyle(
                              color: Colors.orange, fontSize: 20),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          projectContent[index],
                          style: AppTextStyles.normalStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              AppImage.shere,
                              width: 25,
                              height: 25,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _fadeDowntext() {
    return FadeInDown(
      child: RichText(
        text: TextSpan(
          text: 'Latest',
          style: Apptext.addstyles(Colors.white),
          children: [
            TextSpan(
              text: '  projects',
              style: Apptext.addstyles(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
