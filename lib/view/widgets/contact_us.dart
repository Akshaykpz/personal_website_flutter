import 'dart:convert';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:http/http.dart' as http;

class ContactMe extends StatefulWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  State<ContactMe> createState() => _ContactMeState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController contentController = TextEditingController();
final TextEditingController messageController = TextEditingController();

Future sendemail() async {
  const serviceId = 'service_01uj5cm';
  const userId = '6QkiRE5XFrLpJdZXu';
  const templateId = 'template_d7983hp';
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {'origin': 'http:localhost', 'Content-Type': 'Application/json'},
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'name': nameController.text,
          'subject': messageController.text,
          'message': contentController.text,
          'user_email': emailController.text,
        }
      }));
  log(response.statusCode);
  return response.statusCode;
}

class _ContactMeState extends State<ContactMe> {
  @override
  void dispose() {
    super.dispose();
  }

  bool isData = false;
  final Color buttonColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        alignment: Alignment.center,
        color: Colors.transparent,
        height: size.height * 0.8,
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
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(12),
                  child: TextFormField(
                    controller: nameController,
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
                    controller: emailController,
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
                    controller: phoneController,
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
                    controller: contentController,
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
              controller: messageController,
              maxLines: 10,
              decoration: inputFiled(hinttext: 'Your Message'),
            ),
          ),
          const SizedBox(
            height: 30,
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
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 20,
                            color: Colors.white),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.blue,
                          Colors.purple,
                        ],
                      ))
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 5,
                            color: Colors.transparent),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.blue,
                          Colors.purple,
                        ],
                      )),
              child: Center(
                  child: Text(
                'Send Message',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isData ? Colors.white : Colors.white),
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
