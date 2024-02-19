import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/textstyle.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  State<ContactMe> createState() => _ContactMeState();
}

class _ContactMeState extends State<ContactMe> {
  bool isData = false;
  final Color buttonColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        alignment: Alignment.center,
        color: Colors.transparent,
        height: size.height,
        width: size.width,
        child: Column(children: [
          FadeInDown(
              child: RichText(
                  text: TextSpan(
                      text: 'Contact',
                      style: Apptext.addstyles(Colors.white),
                      children: [
                TextSpan(
                  text: '  Me',
                  style: Apptext.addstyles(Colors.blue),
                )
              ]))),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    decoration: inputFiled(hinttext: 'Full Name'),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    decoration: inputFiled(hinttext: 'Email'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    decoration: inputFiled(hinttext: 'Phone Number'),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    decoration: inputFiled(hinttext: 'Email Content'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Material(
            color: Colors.transparent,
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: TextFormField(
              maxLines: 10,
              decoration: inputFiled(hinttext: 'Your Message'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                isData = value;
              });
            },
            child: Container(
              height: 50,
              width: 200,
              decoration: isData
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: buttonColor,
                      boxShadow: [
                          BoxShadow(color: buttonColor, blurRadius: 10),
                          BoxShadow(color: buttonColor, blurRadius: 20),
                          BoxShadow(color: buttonColor, blurRadius: 40),
                        ])
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
              child: const Center(
                  child: Text(
                'Send Message',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              )),
            ),
          )
        ]));
  }

  InputDecoration inputFiled({required String hinttext}) {
    return InputDecoration(
        hintText: hinttext,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        filled: true,
        focusColor: Colors.blueGrey);
  }
}
