import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/box.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';

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

    return HelperClass(
        mobile: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            builddataText(),
            Constants.sizedBox(height: 60.0),
            InkWell(
              onTap: () {},
              onHover: (value) {
                setState(() {
                  isoffhover = value;
                });
              },
              child: animatedcontiner(
                  ishover: isoffhover,
                  image: AppImage.andriod,
                  text: 'Andriod Application'),
            ),
            Constants.sizedBox(height: 24.0),
            InkWell(
              onTap: () {},
              onHover: (value) {
                setState(() {
                  isdata = value;
                });
              },
              child: animatedcontiner(
                  ishover: isdata,
                  image: AppImage.apple,
                  text: 'Ios Application'),
            ),
            Constants.sizedBox(height: 24.0),
            InkWell(
              onTap: () {},
              onHover: (value) {
                setState(() {
                  isonHover = value;
                });
              },
              child: animatedcontiner(
                  ishover: isonHover,
                  image: AppImage.webapp,
                  text: 'Web Application'),
            )
          ],
        ),
        tablet: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            builddataText(),
            Constants.sizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      isoffhover = value;
                    });
                  },
                  child: animatedcontiner(
                      ishover: isoffhover,
                      image: AppImage.andriod,
                      text: 'Andriod Application'),
                ),
                Constants.sizedBox(width: 24.0),
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      isdata = value;
                    });
                  },
                  child: animatedcontiner(
                      ishover: isdata,
                      image: AppImage.apple,
                      text: 'Ios Application'),
                ),
                Constants.sizedBox(width: 24.0),
                InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      isonHover = value;
                    });
                  },
                  child: animatedcontiner(
                      ishover: isonHover,
                      image: AppImage.webapp,
                      text: 'Web Application'),
                )
              ],
            )
          ],
        ),
        desktop: Column(mainAxisSize: MainAxisSize.min, children: [
          builddataText(),
          Constants.sizedBox(height: 60.0),
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
                child: animatedcontiner(
                    ishover: isoffhover,
                    image: AppImage.andriod,
                    text: 'Andriod Application'),
              ),
              Constants.sizedBox(width: 24.0),
              InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    isdata = value;
                  });
                },
                child: animatedcontiner(
                    ishover: isdata,
                    image: AppImage.apple,
                    text: 'Ios Application'),
              ),
              Constants.sizedBox(width: 24.0),
              InkWell(
                onTap: () {},
                onHover: (value) {
                  setState(() {
                    isonHover = value;
                  });
                },
                child: animatedcontiner(
                    ishover: isonHover,
                    image: AppImage.webapp,
                    text: 'Web Application'),
              )
            ],
          )
        ]),
        paddingWidth: size.width * 0.04,
        bgColor: AppColors.bgcolors);

    //      Column(children: [
    //       const SizedBox(
    //         height: 100,
    //       ),
    //       builddataText(),
    //       const SizedBox(
    //         height: 50,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           InkWell(
    //               onTap: () {},
    //               onHover: (value) {
    //                 setState(() {
    //                   isoffhover = value;
    //                 });
    //               },
    //               child: animatedcontiner(
    //                   ishover: isoffhover,
    //                   image: AppImage.andriod,
    //                   text: 'Andriod Application')),
    //           InkWell(
    //               onTap: () {},
    //               onHover: (value) {
    //                 setState(() {
    //                   isdata = value;
    //                 });
    //               },
    //               child: animatedcontiner(
    //                   ishover: isdata,
    //                   image: AppImage.apple,
    //                   text: 'Ios Application')),
    //           InkWell(
    //               onTap: () {},
    //               onHover: (value) {
    //                 setState(() {
    //                   isonHover = value;
    //                 });
    //               },
    //               child: animatedcontiner(
    //                   ishover: isonHover,
    //                   image: AppImage.webapp,
    //                   text: 'Web Application'))
    //         ],
    //       )
    //     ]),
    //   ),
    // );
  }

  FadeInDown builddataText() {
    return FadeInDown(
        child: RichText(
            text: TextSpan(
                text: 'My',
                style: Apptext.addstyles(Colors.white),
                children: [
          TextSpan(
            text: '  Services',
            style: Apptext.addstyles(Colors.white),
          )
        ])));
  }

  AnimatedContainer animatedcontiner(
      {required bool ishover, required String image, required String text}) {
    return AnimatedContainer(
      transform: ishover ? isHoverActive : isHoverRemove,
      width: ishover ? 350 : 300,
      height: ishover ? 350 : 300,
      decoration: BoxDecoration(
          border: ishover ? Border.all(color: Colors.white24, width: 2) : null,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
                color: Colors.transparent,
                blurRadius: 3.5,
                spreadRadius: 3.0,
                offset: Offset(3.0, 4.5))
          ]),
      duration: const Duration(milliseconds: 600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            image,
            height: 250,
          ),
          Text(
            text,
            style: Apptext.aboutstyles1(),
          )
        ],
      ),
    );
  }
}
