import 'dart:io';
import 'package:artisian/helper/custom_text_field.dart';
import 'package:artisian/view/landing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login_Screen extends StatefulWidget {
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool progress = false;
  bool? isChecked = false;
  void signinerror(String error_message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Authentication Failed!'),
              content: Text(error_message),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'))
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
  /* void initState() {

    success_message();
  } */

  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: progress,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      height: 300,
                      child: Image.asset(
                        "assets/icons/logo (2).png",
                        height: 300,
                      ),
                    ),
                  ],
                ),
                Form(
                  child: Column(
                    children: [
                      Container(
                        height: 66,
                        width: 380,
                        child: TextField(
                          controller: email,
                          decoration:
                              ThemeHelper().textInputDecoration('Email', ''),
                          style: TextStyle(fontSize: 17),
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      SizedBox(height: 24.0),
                      Container(
                        height: 66,
                        width: 380,
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          decoration: ThemeHelper().textInputDecoration(
                              'Password', 'Enter your password'),
                          style: TextStyle(fontSize: 17),
                        ),
                        decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      ),
                      SizedBox(height: 17.0),
                      SizedBox(
                        height: 27,
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 150,
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
                                            builder: (context) => Landing()));
                                  }
                                  setState(() {
                                    progress = false;
                                  });
                                } on HttpException catch (error) {
                                  var error_message = 'Authentication failed';
                                  if (error
                                      .toString()
                                      .contains('EMAIL_EXISTS')) {
                                    error_message = 'Email already exits';
                                  }
                                  if (error
                                      .toString()
                                      .contains('EMAIL_NOT_FOUND')) {
                                    error_message = 'Email not found!!';
                                  }
                                  if (error
                                      .toString()
                                      .contains('INVALID_PASSSWORD')) {
                                    error_message = 'Password incorrect!!';
                                  }
                                  signinerror(error_message);
                                } catch (e) {
                                  var error_message = 'Authentication failed';
                                  signinerror(error_message);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp,
                                      color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 17,
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
