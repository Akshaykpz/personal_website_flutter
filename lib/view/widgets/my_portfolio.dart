import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';

import 'package:my_personal_website/constants/image.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:my_personal_website/helper/helper_class.dart';

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  // ignore: prefer_typing_uninitialized_variables
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
    return HelperClass(
      bgColor: AppColors.bgcolors,
      mobile: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          fadeDowntext(),
          const SizedBox(
            height: 45,
          ),
          buildprojectview(titles, appset, 1)
        ],
      ),
      tablet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          fadeDowntext(),
          const SizedBox(
            height: 45,
          ),
          buildprojectview(titles, appset, 2)
        ],
      ),
      desktop: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          fadeDowntext(),
          const SizedBox(
            height: 45,
          ),
          buildprojectview(titles, appset, 2)
        ],
      ),
    );
  }

  GridView buildprojectview(
      Map<String, dynamic> titles, List<String> appset, int crossaccesscount) {
    return GridView.builder(
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
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                            image,
                          ),
                          fit: BoxFit.contain)),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(30),
                //   child: Image(
                //     height: 290,
                //     image: AssetImage(
                //       image,
                //     ),
                //   ),
                // ),
                visbity(index, context, title, description, 'okey'),
              ],
            ),
          ),
        );
      },
    );
  }

  FadeInDown fadeDowntext() {
    return FadeInDown(
        child: RichText(
            text: TextSpan(
                text: 'Latest',
                style: Apptext.addstyles(
                  Colors.white,
                ),
                children: [
          TextSpan(
            text: '  projects',
            style: Apptext.addstyles(Colors.white),
          )
        ])));
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
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
            borderRadius: BorderRadius.circular(20)),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width * 0.01,
            ),
          ),

          Text(
            head,
            style: TextStyle(
              color: Colors.white60,
              fontSize: MediaQuery.of(context).size.width * 0.01,
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          const CircleAvatar(
            child: Icon(Icons.share),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
        ]),
      ),
    );
  }
}
