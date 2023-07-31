import 'dart:io';

import 'package:artisian/auth/register_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class custom_button extends StatelessWidget {
  final double? width;
  String title;
  String email;
  String passkey;
  custom_button({
    required this.title,
    required this.width,
    required this.email,
    required this.passkey,
  });

  final _firestone = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
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

    return Container(
      height: 50,
      width: width,
      child: ElevatedButton(
        onPressed: () async {
          try {
            final newuser = await _auth.createUserWithEmailAndPassword(
                email: email, password: passkey);
            if (newuser != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegistrationScreen(
                          email: email,
                        )),
              );
            }
          } on HttpException catch (error) {
            print(error);
            var error_message = 'Authentication failed';
            if (error.toString().contains('INVALID_EMAIL')) {
              error_message = 'Invalid email';
            }
            if (error.toString().contains('WEAK_PASSWORD')) {
              error_message = 'Password is weak, Enter another';
            }
            signinerror(error_message);
          } catch (error) {
            print(error);
            var error_message = 'Authentication failed something went wrong';
            signinerror(error_message);
          }
          // Get.to(Login_View());
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
              title,
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            Icon(Icons.arrow_forward_ios_sharp, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
