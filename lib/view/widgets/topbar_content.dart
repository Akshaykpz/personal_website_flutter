// import 'package:flutter/material.dart';
// import 'package:my_personal_website/constants/textstyle.dart';

// class TopBar extends StatefulWidget {
//   const TopBar({Key? key}) : super(key: key);

//   @override
//   State<TopBar> createState() => _TopBarState();
// }

// class _TopBarState extends State<TopBar> {
//   @override
//   Widget build(BuildContext context) {
//     final List _ishover = [
//       false,
//       false,
//       false,
//       false,
//       false,
//       false,
//       false,
//       false,
//     ];
//     var screensize = MediaQuery.of(context).size;
//     return Container(
//       color: Colors.transparent,
//       padding: const EdgeInsets.all(20),
//       child: Expanded(
//           child: Row(
//         children: [
//           SizedBox(
//             width: screensize.width / 4,
//           ),
//           Text(
//             'Portfolio',
//             style: Apptext.headertextstyle(),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           InkWell(
//             onHover: (value) {
//               setState(
//                 () {
//                   value ? _ishover[0] = true : _ishover[0] = false;
//                 },
//               );
//             },
//             onTap: () {},
//             child: Column(children: [
//               OnHov(
//                 'Home',
//                 style:
//                     TextStyle(color: _ishover[0] ? Colors.red : Colors.black),
//               ),
//             ]),
//           )
//         ],
//       )),
//     );
//   }
// }
