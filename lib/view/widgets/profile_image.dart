import 'package:flutter/material.dart';

import 'package:my_personal_website/constants/image.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage>
    with TickerProviderStateMixin {
  late final AnimationController _animationContoller;
  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _animationContoller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    _animation = Tween(begin: const Offset(0, 0), end: const Offset(0, 0.2))
        .animate(_animationContoller);
  }

  @override
  void dispose() {
    super.dispose();
    _animationContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      // child: Image.asset(
      //   AppImage.image,
      //   width: 340,
      //   height: 450,
      //   fit: BoxFit.fill,
      // )
      child: CircleAvatar(
        maxRadius: 135,
        backgroundColor: Colors.white10,

        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ClipOval(
              child: SizedBox.fromSize(
            size: const Size.fromRadius(
              140.6,
            ),
            child: Image.asset(
              AppImage.image,
              width: 340,
              height: 450,
              fit: BoxFit.fill,
            ),
          )),
        ),
        // backgroundImage: AssetImage(
        //   AppImage.image,
        // ),
      ),
    );
  }
}
