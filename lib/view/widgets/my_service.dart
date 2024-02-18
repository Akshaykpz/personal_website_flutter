import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  bool isoffhover = false, isdata = false, isonHover = false;
  final isHoverActive = Matrix4.identity()..translate(0, -10, 0);
  final isHoverRemove = Matrix4.identity()..translate(0, 0, 0);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: Column(children: [
        FadeInDown(
            child: RichText(
                text: TextSpan(
                    text: 'My',
                    style: Apptext.addstyles(Colors.white),
                    children: [
              TextSpan(
                text: '  Services',
                style: Apptext.addstyles(Colors.blue),
              )
            ]))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    isoffhover = value;
                  });
                },
                child: animatedcontiner(ishover: isoffhover)),
            InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    isdata = value;
                  });
                },
                child: animatedcontiner(ishover: isdata)),
            InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    isonHover = value;
                  });
                },
                child: animatedcontiner(ishover: isonHover))
          ],
        )
      ]),
    );
  }

  AnimatedContainer animatedcontiner({required bool ishover}) {
    return AnimatedContainer(
      transform: ishover ? isHoverActive : isHoverRemove,
      width: ishover ? 400 : 360,
      height: ishover ? 400 : 360,
      decoration: BoxDecoration(
          border: ishover ? Border.all(color: Colors.green, width: 2) : null,
          color: Colors.red,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
                color: Colors.blue,
                blurRadius: 3.5,
                spreadRadius: 3.0,
                offset: Offset(3.0, 4.5))
          ]),
      duration: const Duration(milliseconds: 600),
      child: Column(
        children: [
          Image.asset(AppImage.flutter),
          Text(
            'App Development',
            style: Apptext.biodatas(),
          ),
        ],
      ),
    );
  }
}
