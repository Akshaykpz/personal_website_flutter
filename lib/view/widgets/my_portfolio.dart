import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

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
    List<String> appset = [
      AppImage.project1,
      AppImage.project2,
      AppImage.project3
    ];

    Map<String, dynamic> titles = {
      'Aqua Med Tarcker':
          'Aqua Med-Tracker it is a reminder Application helping for track water and medicines',
      'StoreX':
          'Developed a sleek eCommerce app with Cart, Wishlist, Store, and,admin panel',
      'Chatgpt': 'Developed a Ai bot it is model chat gpt'
    };

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
                  style: Apptext.addstyles(Colors.white),
                )
              ]))),
          const SizedBox(
            height: 45,
          ),
          GridView.builder(
            itemCount: titles.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 300,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24),
            itemBuilder: (context, index) {
              var image = appset[index];

              String title = titles.keys.elementAt(index);
              String description = titles.values.elementAt(index);

              return FadeInUpBig(
                duration: const Duration(milliseconds: 600),
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
                          height: 290,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                      visbity(index, context, title, description, 'okey'),
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

  Visibility itemContiner(
    String data,
    int index,
    BuildContext context,
  ) {
    return Visibility(
      visible: index == isvalue,
      child: Container(
        width: 60,
        height: 25,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          child: Text(
            data,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Visibility visbity(
      int index, BuildContext context, String text, String head, String okey) {
    return Visibility(
      visible: index == isvalue,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        width: MediaQuery.sizeOf(context).width * 0.2,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              head,
              style: const TextStyle(color: Colors.white60),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const CircleAvatar(
            child: Icon(Icons.share),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
