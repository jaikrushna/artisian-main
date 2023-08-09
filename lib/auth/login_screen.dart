// ignore_for_file: use_build_context_synchronously, camel_case_types

import 'dart:io';
import 'package:artisian/helper/custom_text_field.dart';
import 'package:artisian/view/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

// ignore: camel_case_types
class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool progress = false;
  bool? isChecked = false;
  void signinerror(String errorMessage) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Authentication Failed!'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Okay'))
              ],
            ));
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.disabledColor,
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.022),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.015, //10
                ),
                Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.35,
                      child: Image.asset(
                        "assets/icons/logo (2).png",
                        height: size.height * 0.35,
                      ),
                    ),
                  ],
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.078, //66
                        width: size.width * 0.90,
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextField(
                          controller: email,
                          decoration:
                              ThemeHelper().textInputDecoration('Email', ''),
                          style: TextStyle(fontSize: size.width * 0.042),
                        ),
                      ),
                      SizedBox(height: size.height * 0.030),
                      Container(
                        height: size.height * 0.078, //66
                        width: size.width * 0.90,
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          decoration: ThemeHelper().textInputDecoration(
                              'Password', 'Enter your password'),
                          style: TextStyle(fontSize: size.width * 0.042),
                        ),
                      ),
                      SizedBox(height: size.height * 0.022),
                      Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.063,
                            width: size.width * 0.55,
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  setState(() {
                                    progress = true;
                                  });
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                  if (user != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Landing()));
                                  }
                                  setState(() {
                                    progress = false;
                                  });
                                } on HttpException catch (error) {
                                  var errorMessage = 'Authentication failed';
                                  if (error
                                      .toString()
                                      .contains('EMAIL_EXISTS')) {
                                    errorMessage = 'Email already exits';
                                  }
                                  if (error
                                      .toString()
                                      .contains('EMAIL_NOT_FOUND')) {
                                    errorMessage = 'Email not found!!';
                                  }
                                  if (error
                                      .toString()
                                      .contains('INVALID_PASSSWORD')) {
                                    errorMessage = 'Password incorrect!!';
                                  }
                                  signinerror(errorMessage);
                                } catch (e) {
                                  var errorMessage = 'Authentication failed';
                                  signinerror(errorMessage);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      size.height * 0.030),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue',
                                    style: GoogleFonts.poppins(
                                        fontSize: size.width * 0.038,
                                        color: theme.disabledColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_sharp,
                                      color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
