import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  var isvalue;
  @override
  Widget build(BuildContext context) {
    List<String> appset = [AppImage.dart, AppImage.flutter, AppImage.instagram];

    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: size.width * 0.1),
      alignment: Alignment.center,
      color: Colors.transparent,
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          FadeInDown(
              child: RichText(
                  text: TextSpan(
                      text: 'Latest',
                      style: Apptext.addstyles(Colors.white),
                      children: [
                TextSpan(
                  text: '  projects',
                  style: Apptext.addstyles(Colors.blue),
                )
              ]))),
          GridView.builder(
            itemCount: appset.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 300,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24),
            itemBuilder: (context, index) {
              var image = appset[index];
              return FadeInUpBig(
                duration: Duration(milliseconds: 600),
                child: InkWell(
                  onTap: () {},
                  onHover: (value) {
                    setState(() {
                      setState(() {
                        if (value) {
                          isvalue = index;
                        } else {
                          isvalue = null;
                        }
                      });
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: index == isvalue,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 600),
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          height: MediaQuery.sizeOf(context).height,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30)),
                          child: const Column(children: [
                            Text('data'),
                            CircleAvatar(
                              child: Icon(Icons.share),
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
