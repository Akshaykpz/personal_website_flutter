// // import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:my_personal_website/constants/textstyle.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:my_personal_website/helper/helper_class.dart';

// class Expierence extends StatefulWidget {
//   const Expierence({Key? key}) : super(key: key);

//   @override
//   State<Expierence> createState() => _ExpierenceState();
// }

// class _ExpierenceState extends State<Expierence> {
//   bool isHoverActive = false;
//   bool isHoverRemove = false;

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final bool isMobile = size.width < 600;

//     return Container(
//       color: Colors.amber,
//       height: size.height * 0.9,
//       width: size.width,
//       child: HelperClass(
//         mobile: Column(
//           children: [expierenceFilter(context)],
//         ),
//         tablet: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [expierenceFilter(context)],
//         ),
//         desktop: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [expierenceFilter(context)],
//         ),
//       ),
//     );
//   }

//   Widget expierenceFilter(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         FadeInDown(
//           child: RichText(
//             text: TextSpan(
//               text: 'Experience',
//               style: Apptext.addstyles(Colors.white),
//             ),
//           ),
//         ),
//         SizedBox(height: 20),
//         Text(
//           'Experience My work experience as a Flutter Developer and working on different companies and projects',
//           style: Apptext.aboutstyles(),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 60),
//         Row(
//           children: [
//             InkWell(
//               onTap: () {},
//               onHover: (value) {
//                 setState(() {
//                   isHoverActive = value;
//                 });
//               },
//               child: animatedContiner(
//                 context,
//                 'assets/images/WhatsApp Image 2024-02-29 at 11.56.24_4da76985.jpg',
//                 isHoverActive,
//                 ': Flutter Developer',
//                 '  : Grand Cafe Production',
//                 ': Nov 2023 - Jan 2024',
//                 'Working on Rental Platforms,managing Both Frontend&Backend, and Figam design from the scratch',
//               ),
//             ),
//             SizedBox(width: 50),
//             InkWell(
//               onTap: () {},
//               onHover: (value) {
//                 setState(() {
//                   isHoverRemove = value;
//                 });
//               },
//               child: animatedContiner(
//                 context,
//                 'assets/images/WhatsApp Image 2024-02-29 at 18.41.19_76132ea6.jpg',
//                 isHoverRemove,
//                 ': Flutter Developer',
//                 'Brototype',
//                 ': Jan 2023 - Nov 2023',
//                 'I have a solid foundation in Flutter Development, acquired through a successful internship at Brototype. Over the subsequent eight months, I accomplished the delivery of two significant projects, in addition to several mini-projects, showcasing my proficiency and commitment in the field',
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget animatedContiner(
//     BuildContext context,
//     String image,
//     bool isHover,
//     String text1,
//     String text2,
//     String text3,
//     String text4,
//   ) {
//     final double containerWidth = MediaQuery.of(context).size.width * 0.3;
//     final double containerHeight = MediaQuery.of(context).size.height * 0.4;
//     final double imageSize = MediaQuery.of(context).size.width * 0.04;
//     final double fontSize = MediaQuery.of(context).size.width * 0.01;

//     return AnimatedContainer(
//       // transform: isHover?isHoverActive:isHoverRemove,
//       width: isHover ? containerWidth * 1.1 : containerWidth,
//       height: isHover ? containerHeight * 1.1 : containerHeight,
//       duration: const Duration(milliseconds: 100),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: const Color.fromRGBO(0, 0, 0, 0.122),
//         gradient: const LinearGradient(
//           colors: [Colors.blue, Colors.purple],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         border: Border.all(
//           style: BorderStyle.solid,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//                 child: Expanded(
//                   child: Image.asset(
//                     image,
//                     fit: BoxFit.contain,
//                     width: imageSize,
//                   ),
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     text1,
//                     style: TextStyle(fontSize: fontSize, color: Colors.white),
//                   ),
//                   Text(
//                     text2,
//                     style: TextStyle(fontSize: fontSize, color: Colors.white),
//                   ),
//                   Text(
//                     text3,
//                     style: TextStyle(fontSize: fontSize, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text(
//               text4,
//               style: Apptext.aboutstyles2(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:animate_do/animate_do.dart';
import 'package:my_personal_website/helper/helper_class.dart';

class Expierence extends StatefulWidget {
  const Expierence({Key? key}) : super(key: key);

  @override
  State<Expierence> createState() => _ExpierenceState();
}

class _ExpierenceState extends State<Expierence> {
  bool isoffhover = false, isdata = false, isonHover = false;
  final isHoverActive = Matrix4.identity()..translate(0, -10, 0);
  final isHoverRemove = Matrix4.identity()..translate(0, 0, 0);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    return Container(
      // color: Colors.amber,
      height: size.height * 0.9,
      width: size.width,
      child: HelperClass(
        mobile: Column(
          children: [expierenceFilter(context)],
        ),
        tablet: Row(
          children: [expierenceFilter(context)],
        ),
        desktop: Row(
          children: [expierenceFilter(context)],
        ),
      ),
    );
  }

  Widget expierenceFilter(BuildContext context) {
    return SingleChildScrollView(
      // Wrap with SingleChildScrollView
      physics: AlwaysScrollableScrollPhysics(), // Set physics property
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FadeInDown(
            child: RichText(
              text: TextSpan(
                text: 'Experience',
                style: Apptext.addstyles(Colors.white),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Experience My work experience as a Flutter Developer and working on different companies and projects',
            style: Apptext.aboutstyles(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // Align children in the center horizontally
            children: [
              InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    isonHover = value;
                  });
                },
                child: animatedContiner(
                  context,
                  'assets/images/WhatsApp Image 2024-02-29 at 11.56.24_4da76985.jpg',
                  isonHover,
                  ': Flutter Developer',
                  '  : Grand Cafe Production',
                  ': Nov 2023 - Jan 2024',
                  'Working on Rental Platforms,managing Both Frontend&Backend, and Figam design from the scratch',
                ),
              ),
              SizedBox(width: 100),
              InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    isoffhover = value;
                  });
                },
                child: animatedContiner(
                  context,
                  'assets/images/WhatsApp Image 2024-02-29 at 18.41.19_76132ea6.jpg',
                  isoffhover,
                  ': Flutter Developer',
                  'Brototype',
                  ': Jan 2023 - Nov 2023',
                  'I have a solid foundation in Flutter Development, acquired through a successful internship at Brototype. Over the subsequent eight months, I accomplished the delivery of two significant projects, in addition to several mini-projects, showcasing my proficiency and commitment in the field',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget animatedContiner(
    BuildContext context,
    String image,
    bool isHover,
    String text1,
    String text2,
    String text3,
    String text4,
  ) {
    final double containerWidth = MediaQuery.of(context).size.width * 0.3;
    final double containerHeight = MediaQuery.of(context).size.height * 0.3;
    final double imageSize = MediaQuery.of(context).size.width * 0.04;
    final double fontSize = MediaQuery.of(context).size.width * 0.01;

    return AnimatedContainer(
      transform: isHover ? isHoverActive : isHoverRemove,
      width: isHover ? containerWidth * 1.1 : containerWidth,
      height: isHover ? containerHeight * 1.1 : containerHeight,
      duration: const Duration(seconds: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(0, 0, 0, 0.122),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Column(
        // Change from Column to Row
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                width: imageSize,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text1,
                style: TextStyle(fontSize: fontSize, color: Colors.white),
              ),
              Text(
                text2,
                style: TextStyle(fontSize: fontSize, color: Colors.white),
              ),
              Text(
                text3,
                style: TextStyle(fontSize: fontSize, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
