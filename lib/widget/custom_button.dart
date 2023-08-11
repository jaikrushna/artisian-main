// ignore_for_file: must_be_immutable, camel_case_types, use_build_context_synchronously

import 'dart:io';
import 'package:artisian/view/landing.dart';
import 'package:artisian/viewmodel/course_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artisian/viewmodel/post_view_model.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:provider/provider.dart';

class custom_button extends StatelessWidget {
  final double? width;
  String email;
  String passkey;
  String agetext;
  String selectedAvatar;
  String nametext;
  String hobbytext;
  String biotext;
  custom_button({
    Key? key,
    required this.width,
    required this.email,
    required this.passkey,
    required this.selectedAvatar,
    required this.agetext,
    required this.hobbytext,
    required this.biotext,
    required this.nametext,
  }) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    CourseViewModel courseModel = Provider.of<CourseViewModel>(context);
    PostViewModel postModel = Provider.of<PostViewModel>(context);
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

    return SizedBox(
      height: size.height * 0.065,
      width: width,
      child: ElevatedButton(
        onPressed: () async {
          if (nametext.isEmpty ||
              agetext.isEmpty ||
              biotext.isEmpty ||
              hobbytext.isEmpty ||
              selectedAvatar.isEmpty) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Warning'),
                content: const Text('Please fill in all fields'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else {
            try {
              await _auth.createUserWithEmailAndPassword(
                  email: email, password: passkey);
              int age = int.tryParse(agetext) ?? 0;
              viewModel.addUser(
                imageUrl: selectedAvatar,
                name: nametext,
                age: age,
                bio: biotext,
                date: DateTime.now(),
                hobby: hobbytext,
                email: email,
                streak: 0,
              );
              courseModel.addCourse(email: email, level: 'Beginner');
              courseModel.addCourse(email: email, level: 'Intermediate');
              courseModel.addCourse(email: email, level: 'Advance');
              postModel.PostNew(email: email);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Landing()));
            } on HttpException catch (error) {
              var errorMessage = 'Authentication failed';
              if (error.toString().contains('INVALID_EMAIL')) {
                errorMessage = 'Invalid email';
              }
              if (error.toString().contains('WEAK_PASSWORD')) {
                errorMessage = 'Password is weak, Enter another';
              }
              signinerror(errorMessage);
            } catch (error) {
              var errorMessage = 'Authentication failed something went wrong';
              signinerror(errorMessage);
            }
            // Get.to(Login_View());
          }
          ;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.height * 0.030),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: GoogleFonts.poppins(
                  fontSize: size.height * 0.020,
                  color: theme.disabledColor,
                  fontWeight: FontWeight.w400),
            ),
            const Icon(Icons.arrow_forward_ios_sharp, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
