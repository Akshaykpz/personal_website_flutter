// import 'package:flutter/material.dart';
// import 'package:my_personal_website/constants/colors.dart';
// import 'package:my_personal_website/constants/textstyle.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({Key? key}) : super(key: key);

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   final onmenuHover = Matrix4.identity()..scale(1.0);
//   final menuitem = <String>[
//     'About',
//     'Skills',
//     'Experience',
//     'Service',
//     'Projects',
//     'Projects',
//   ];
//   final Color backgroundColor = Color.fromARGB(255, 13, 16, 28);
//   final Color buttonColor = Colors.blue;
//   var menuIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bgcolors,
//       appBar: AppBar(
//         titleSpacing: 100,
//         toolbarHeight: 90,
//         backgroundColor: AppColors.bgcolors,
//         elevation: 0,
//         title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           Text(
//             'Portfolio',
//             style: Apptext.biodatas(context),
//           ),
//           const Spacer(),
//           SizedBox(
//             height: 40,
//             child: ListView.separated(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) => const SizedBox(
//                       width: 3,
//                     ),
//                 separatorBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {},
//                     borderRadius: BorderRadius.circular(100),
//                     onHover: (value) {
//                       setState(() {
//                         if (value) {
//                           menuIndex = index;
//                         } else {
//                           menuIndex = 0;
//                         }
//                       });
//                     },
//                     child: animatedContainer(
//                         index, menuIndex == index ? true : false),
//                   );
//                 },
//                 itemCount: menuitem.length),
//           ),
//         ]),
//       ),
//     );
//   }

//   AnimatedContainer animatedContainer(int index, bool hover) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       alignment: Alignment.center,
//       width: hover ? 90 : 85,
//       transform: hover ? onmenuHover : null,
//       child: Text(menuitem[index],
//           style: Apptext.headertextstyle(
//             context,
//             hover ? Colors.blue : Colors.white,
//           )),
//     );
//   }
// }
