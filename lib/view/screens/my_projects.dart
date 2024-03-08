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
  final onH0verEffect = Matrix4.identity()..scale(1.0);
  // ignore: prefer_typing_uninitialized_variables
  var isvalue;
  @override
  Widget build(BuildContext context) {
    List<String> appset = [
      AppImage.project1,
      AppImage.project2,
      AppImage.project3,
      AppImage.wheather,
      AppImage.netflix,
      AppImage.music
    ];

    Map<String, dynamic> titles = {
      'Aqua Med Tarcker':
          'Aqua Med-Tracker it is a reminder Application helping for track water and medicines',
      'StoreX':
          'Developed a sleek eCommerce app with Cart, Wishlist, Store, and,admin panel',
      'Chatgpt': 'Developed a Ai bot it is model chat gpt',
      'Netflix Clone':
          'Developed a Netflix UI clone in Flutter, integrating the TMDB API for movie searches, descriptions, and trailers',
      'Wheather App':
          'Developed a wheather UI clone in Flutter integrating wheather app using API searching ,location base weather detiles',
      'Music App':
          'A Flutter music streaming application that allows users to play audio files from local storage. The app features a beautiful neumorphic UI desion.'
    };

    final size = MediaQuery.of(context).size;
    return HelperClass(
      paddingWidth: size.width * 0.1,
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
          buildprojectview(titles, appset, 3)
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossaccesscount,
        mainAxisExtent: 280,
        mainAxisSpacing: 40,
        crossAxisSpacing: 40,
      ),
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(
                            image,
                          ),
                          fit: BoxFit.contain)),
                ),
                visbity(index, context, title, description, 'hai'),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
        transform: index == isvalue ? onH0verEffect : null,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 600),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width * 0.01,
            ),
            textAlign: TextAlign.center,
          ),

          Text(
            head,
            style: TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.w300,
              fontSize: MediaQuery.of(context).size.width * 0.01,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          )
          // const SizedBox(
          //   height: 20,
          // ),
        ]),
      ),
    );
  }
}
