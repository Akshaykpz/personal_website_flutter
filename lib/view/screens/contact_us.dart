import 'dart:convert';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/box.dart';
import 'package:my_personal_website/constants/colors.dart';
import 'package:my_personal_website/constants/textstyle.dart';
import 'package:http/http.dart' as http;
import 'package:my_personal_website/helper/helper_class.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  State<ContactMe> createState() => _ContactMeState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController contentController = TextEditingController();
final TextEditingController messageController = TextEditingController();
void showSnackBar(BuildContext context) {
  const snackBar = SnackBar(
    content: Text('Message Sent Sucessfully'),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    width: 500,
    duration: Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

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

  nameController.clear();
  emailController.clear();
  phoneController.clear();
  contentController.clear();
  messageController.clear();

  return response.statusCode;
}

class _ContactMeState extends State<ContactMe> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isData = false;
  bool isloading = false;
  final Color buttonColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return HelperClass(
        paddingWidth: size.width * 0.1,
        bgColor: Colors.transparent,
        mobile: customMethod(
          context,
        ),
        tablet: customfiled(context, _formkey),
        desktop: customfiled(context, _formkey));
  }

  Form customMethod(
    BuildContext context,
  ) {
    return Form(
      key: _formkey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            formtext(),
            Material(
              color: Colors.transparent,
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'please enter name';
                },
                style: const TextStyle(color: Colors.white),
                controller: nameController,
                decoration: inputFiled(hinttext: 'Full Name'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              color: Colors.transparent,
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  }
                  // Email regex pattern
                  const emailPattern =
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  final regex = RegExp(emailPattern);
                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                controller: emailController,
                decoration: inputFiled(hinttext: 'Email'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              color: Colors.transparent,
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: TextFormField(
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'please enter phone';
                },
                style: const TextStyle(color: Colors.white),
                controller: phoneController,
                decoration: inputFiled(hinttext: 'Phone Number'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              color: Colors.transparent,
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: contentController,
                decoration: inputFiled(hinttext: 'Email Content'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              color: Colors.transparent,
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter message';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
                controller: messageController,
                maxLines: 6,
                decoration: inputFiled(hinttext: 'Your Message'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                if (_formkey.currentState?.validate() != true) {
                  return;
                } else {
                  if (isloading) return;
                  setState(() {
                    isloading = true;
                  });
                  await sendemail().then((value) async {
                    isloading = false;
                    showSnackBar(context);
                  });
                }
              },
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
                        border: Border.all(color: AppColors.ebony),
                        borderRadius: BorderRadius.circular(10),

                        // boxShadow: const [
                        //   BoxShadow(
                        //       offset: Offset(0.0, 0.0),
                        //       blurRadius: 10,
                        //       color: Colors.white),
                        // ],
                        // gradient: const LinearGradient(
                        //   begin: Alignment.centerLeft,
                        //   end: Alignment.centerRight,
                        //   colors: [
                        //     Colors.blue,
                        //     Colors.purple,
                        //   ],
                        // )
                      )
                    : Colorss.gradientDecoration(),
                child: Center(
                    child: isloading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Send Message',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isData ? Colors.white : Colors.white),
                          )),
              ),
            )
          ]),
    );
  }

  Form customfiled(BuildContext context, GlobalKey key) {
    return Form(
      key: key,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            formtext(),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'please fill name';
                        },
                        style: const TextStyle(color: Colors.white),
                        controller: nameController,
                        decoration: inputFiled(hinttext: 'Full Name'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          // Email regex pattern
                          const emailPattern =
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                          final regex = RegExp(emailPattern);
                          if (!regex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: inputFiled(hinttext: 'Email'),
                      ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        maxLength: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'please enter phone number';
                        },
                        style: const TextStyle(color: Colors.white),
                        controller: phoneController,
                        decoration: inputFiled(hinttext: 'Phone Number'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 8,
                      borderRadius: BorderRadius.circular(12),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: contentController,
                        decoration: inputFiled(hinttext: 'Email Content'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                color: Colors.transparent,
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return 'please fill message';
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  controller: messageController,
                  maxLines: 6,
                  decoration: inputFiled(hinttext: 'Your Message'),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              child: Container(
                height: 50,
                width: 200,
                decoration: isData
                    ? BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),

                        // boxShadow: const [
                        //   BoxShadow(
                        //       offset: Offset(0.0, 0.0),
                        //       blurRadius: 10,
                        //       color: Colors.white),
                        // ],
                        // gradient: const LinearGradient(
                        //   begin: Alignment.centerLeft,
                        //   end: Alignment.centerRight,
                        //   colors: [
                        //     Colors.blue,
                        //     Colors.purple,
                        //   ],
                        // )
                      )
                    : Colorss.gradientDecoration(),
                child: Center(
                    child: isloading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              Text(
                                "please wait...",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              )
                            ],
                          )
                        : Text(
                            'Send Message',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isData ? Colors.white : Colors.white),
                          )),
              ),
              onTap: () async {
                if (_formkey.currentState?.validate() != true) {
                  return;
                } else {
                  if (isloading) return;
                  setState(() {
                    isloading = true;
                  });
                  await sendemail().then((value) async {
                    isloading = false;
                    showSnackBar(context);
                  });
                }
              },
              onHover: (value) {
                setState(() {
                  isData = value;
                });
              },
            )
          ]),
    );
  }

  FadeInDown formtext() {
    return FadeInDown(
        child: RichText(
            text: TextSpan(
                text: 'Contact',
                style: Apptext.addstyles(Colors.white),
                children: [
          TextSpan(
            text: '  Me',
            style: Apptext.addstyles(Colors.white),
          )
        ])));
  }

  InputDecoration inputFiled({required String hinttext}) {
    return InputDecoration(
      hintText: hinttext,
      fillColor: Colors.transparent,
      hintStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),

        borderSide: const BorderSide(color: Colors.white70), // Change here
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      filled: true,
      focusColor: Colors.blueGrey,
    );
  }
}
