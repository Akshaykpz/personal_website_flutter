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
    // TODO: implement initState
    super.initState();
    _animationContoller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat(reverse: true);
    _animation = Tween(begin: Offset(0, 0.1), end: Offset(0, 0.2))
        .animate(_animationContoller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: CircleAvatar(
        maxRadius: 105,
        backgroundColor: Colors.white30,

        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ClipOval(
              child: SizedBox.fromSize(
            size: const Size.fromRadius(
              104.6,
            ),
            child: Image.asset(
              AppImage.image,
              fit: BoxFit.cover,
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
