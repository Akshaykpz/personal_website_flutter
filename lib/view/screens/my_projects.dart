// import 'package:animate_do/animate_do.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_animated_button/flutter_animated_button.dart';

// import 'package:my_personal_website/constants/colors.dart';

// import 'package:my_personal_website/constants/image.dart';
// import 'package:my_personal_website/constants/textstyle.dart';
// import 'package:my_personal_website/helper/helper_class.dart';

// class MyPortfolio extends StatefulWidget {
//   const MyPortfolio({Key? key}) : super(key: key);

//   @override
//   State<MyPortfolio> createState() => _MyPortfolioState();
// }

// class _MyPortfolioState extends State<MyPortfolio> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   final onH0verEffect = Matrix4.identity()..scale(1.0);
//   // ignore: prefer_typing_uninitialized_variables
//   var isvalue;
//   @override
//   Widget build(BuildContext context) {
//     List<String> appset = [
//       AppImage.project1,
//       AppImage.project2,
//       // AppImage.project3,
//       AppImage.wheather,
//       AppImage.netflix,
//       AppImage.music
//     ];

//     Map<String, dynamic> titles = {
//       'Aqua Med Tarcker':
//           'Aqua Med-Tracker it is a reminder Application helping for track water and medicines',
//       'StoreX':
//           'Developed a sleek eCommerce app with Cart, Wishlist, Store, and,admin panel',
//       'Netflix Clone':
//           'Developed a Netflix UI clone in Flutter, integrating the TMDB API for movie searches, descriptions, and trailers',
//       'Wheather App':
//           'Developed a wheather UI clone in Flutter integrating wheather app using API searching ,location base weather detiles',
//       'Music App':
//           'A Flutter music streaming application that allows users to play audio files from local storage. The app features a beautiful neumorphic UI desion.'
//     };

//     List<String> desccritpionsss = [
//       'Aqua Med-Tracker it is a reminder Application helping for track water and medicines',
//       'Developed a sleek eCommerce app with Cart, Wishlist, Store, and,admin panel',
//       'Developed a Netflix UI clone in Flutter, integrating the TMDB API for movie searches, descriptions, and trailers',
//       'Developed a wheather UI clone in Flutter integrating wheather app using API searching ,location base weather detiles',
//       'A Flutter music streaming application that allows users to play audio files from local storage. The app features a beautiful neumorphic UI desion.'
//     ];

//     final size = MediaQuery.of(context).size;
//     return HelperClass(
//       paddingWidth: size.width * 0.1,
//       bgColor: AppColors.bgcolors,
//       mobile: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           fadeDowntext(),
//           const SizedBox(
//             height: 45,
//           ),
//           buildprojectview(titles, appset, desccritpionsss, 1)
//         ],
//       ),
//       tablet: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           fadeDowntext(),
//           const SizedBox(
//             height: 45,
//           ),
//           buildprojectview(titles, appset, desccritpionsss, 2)
//         ],
//       ),
//       desktop: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           fadeDowntext(),
//           const SizedBox(
//             height: 45,
//           ),
//           buildprojectview(titles, appset, desccritpionsss, 3)
//         ],
//       ),
//     );
//   }

//   GridView buildprojectview(
//       Map<String, dynamic> titles,
//       List<String> appset,
//       List<String> descriptions, // Add descriptions parameter
//       int crossaccesscount) {
//     return GridView.builder(
//       itemCount: titles.length,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossaccesscount,
//         mainAxisExtent: 350,
//         mainAxisSpacing: 40,
//         crossAxisSpacing: 40,
//       ),
//       itemBuilder: (context, index) {
//         var image = appset[index];
//         var description =
//             descriptions[index]; // Get description for current item

//         return FadeInUpBig(
//           duration: const Duration(milliseconds: 600),
//           child: Column(
//             children: [
//               Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.black.withOpacity(0.2),
//                   image: DecorationImage(
//                     image: AssetImage(image),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               InkWell(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         elevation: 4,
//                         content: Container(
//                           height: MediaQuery.of(context).size.height * 0.7,
//                           width: MediaQuery.of(context).size.width * 0.4,
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             children: [
//                               Text(description),
//                               Spacer(),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   AnimatedButton(
//                                     animatedOn: AnimatedOn.onTap,
//                                     height: 50,
//                                     width: 200,
//                                     text: 'PLAY STORE LINK',
//                                     isReverse: true,
//                                     borderColor: Colors.white,
//                                     selectedTextColor: Colors.black,
//                                     transitionType:
//                                         TransitionType.LEFT_TO_RIGHT,
//                                     textStyle: const TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w800),
//                                     backgroundColor: Colors.black,
//                                     borderRadius: 50,
//                                     borderWidth: 2,
//                                     onPress: () {},
//                                   ),
//                                   AnimatedButton(
//                                     height: 50,
//                                     width: 200,
//                                     textStyle: const TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w800),
//                                     text: 'GIT HUB CODE',
//                                     isReverse: true,
//                                     selectedTextColor: Colors.black,
//                                     transitionType:
//                                         TransitionType.LEFT_TO_RIGHT,
//                                     backgroundColor: Colors.black,
//                                     borderColor: Colors.white,
//                                     borderRadius: 50,
//                                     borderWidth: 2,
//                                     onPress: () {},
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ), // Show description in dialog
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     boxShadow: const [
//                       BoxShadow(
//                         offset: Offset(0.0, 0.0),
//                         blurRadius: 3,
//                         color: Colors.transparent,
//                       ),
//                     ],
//                     gradient: LinearGradient(
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                       colors: [
//                         Colors.blue.shade500,
//                         Colors.purple.shade300,
//                       ],
//                     ),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       "More...",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

//   FadeInDown fadeDowntext() {
//     return FadeInDown(
//         child: RichText(
//             text: TextSpan(
//                 text: 'Latest',
//                 style: Apptext.addstyles(
//                   Colors.white,
//                 ),
//                 children: [
//           TextSpan(
//             text: '  projects',
//             style: Apptext.addstyles(Colors.white),
//           )
//         ])));
//   }
// }
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  @override
  Widget build(BuildContext context) {
    final List<String> appset = [
      AppImage.project1,
      AppImage.project2,
      AppImage.wheather,
      AppImage.netflix,
      AppImage.music
    ];

    final Map<String, String> titles = {
      'Aqua Med Tarcker':
          'Aqua Med-Tracker it is a reminder Application helping for track water and medicines',
      'StoreX':
          'Developed a sleek eCommerce app with Cart, Wishlist, Store, and,admin panel',
      'Netflix Clone':
          'Developed a Netflix UI clone in Flutter, integrating the TMDB API for movie searches, descriptions, and trailers',
      'Weather App':
          'Developed a weather UI clone in Flutter integrating weather app using API searching, location-based weather details',
      'Music App':
          'A Flutter music streaming application that allows users to play audio files from local storage. The app features a beautiful neumorphic UI design.'
    };

    final List<String> descriptions = [
      'Aqua Med-Tracker it is a reminder Application helping for track water and medicines',
      'Developed a sleek eCommerce app with Cart, Wishlist, Store, and,admin panel',
      'Developed a Netflix UI clone in Flutter, integrating the TMDB API for movie searches, descriptions, and trailers',
      'Developed a weather UI clone in Flutter integrating weather app using API searching ,location base weather detiles',
      'A Flutter music streaming application that allows users to play audio files from local storage. The app features a beautiful neumorphic UI desion.'
    ];

    final size = MediaQuery.of(context).size;
    return HelperClass(
      paddingWidth: size.width * 0.1,
      bgColor: AppColors.bgcolors,
      mobile: _buildProjectsListView(titles, appset, descriptions, 1),
      tablet: _buildProjectsListView(titles, appset, descriptions, 2),
      desktop: _buildProjectsListView(titles, appset, descriptions, 3),
    );
  }

  Widget _buildProjectsListView(Map<String, String> titles, List<String> appset,
      List<String> descriptions, int crossAxisCount) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _fadeDowntext(),
        const SizedBox(height: 45),
        _buildProjectView(titles, appset, descriptions, crossAxisCount),
      ],
    );
  }

  Widget _buildProjectView(Map<String, String> titles, List<String> appset,
      List<String> descriptions, int crossAxisCount) {
    return GridView.builder(
      itemCount: titles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 350,
        mainAxisSpacing: 40,
        crossAxisSpacing: 40,
      ),
      itemBuilder: (context, index) {
        final String image = appset[index];
        final String description = descriptions[index];
        final String title = titles.keys.elementAt(index);

        return FadeInUpBig(
          duration: const Duration(milliseconds: 600),
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.2),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  _showProjectDetailsDialog(context, title, description);
                },
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 3,
                        color: Colors.transparent,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.blue.shade500,
                        Colors.purple.shade300,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "More...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showProjectDetailsDialog(
      BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) {
        final double dialogWidth = MediaQuery.of(context).size.width * 0.7;
        final double dialogHeight = MediaQuery.of(context).size.height * 0.5;

        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          content: Container(
            width: dialogWidth,
            height: dialogHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(description,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                const Spacer(
                  flex: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: AnimatedButton(
                          animatedOn: AnimatedOn.onTap,
                          height: 50,
                          textAlignment: Alignment.center,
                          text: '  PLAY STORE LINK',
                          isReverse: true,
                          borderColor: Colors.white,
                          selectedTextColor: Colors.black,
                          transitionType: TransitionType.LEFT_TO_RIGHT,
                          textStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800),
                          backgroundColor: Colors.black,
                          borderRadius: 50,
                          borderWidth: 2,
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple]),
                          onPress: () {},
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AnimatedButton(
                          height: 50,
                          text: '  GITHUB CODE',
                          isReverse: true,
                          textStyle: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800),
                          selectedTextColor: Colors.black,
                          transitionType: TransitionType.BOTTOM_CENTER_ROUNDER,
                          backgroundColor: Colors.black,
                          borderColor: Colors.white,
                          borderRadius: 50,
                          borderWidth: 2,
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.purple]),
                          onPress: () {},
                        ),
                      ),
                    ],
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
    )));
  }
}
