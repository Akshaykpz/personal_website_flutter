// import 'package:flutter/material.dart';

// class CircileView extends StatelessWidget {
//   final String image;
//   final VoidCallback? voidCallback;
//   const CircileView({Key? key, required this.image, this.voidCallback});

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) {
//         voidCallback;
//         // Handle hover event
//       },
//       onExit: (_) {
//         // Handle hover exit event
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
//         child: Image.asset(
//           image,
//           height: 20,
//           width: 20,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CircileView extends StatelessWidget {
  final String image;
  final VoidCallback? voidCallback;
  const CircileView({Key? key, required this.image, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (voidCallback != null) {
          voidCallback!();
        }
        // Handle hover event
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Image.asset(
          image,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
