import 'dart:io';
import 'package:artisian/view/landing.dart';
import 'package:artisian/viewmodel/course_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    required this.width,
    required this.email,
    required this.passkey,
    required this.selectedAvatar,
    required this.agetext,
    required this.hobbytext,
    required this.biotext,
    required this.nametext,
  });

  final _firestone = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    CourseViewModel courseModel = Provider.of<CourseViewModel>(context);
    PostViewModel postModel = Provider.of<PostViewModel>(context);
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Landing()));
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
              "Register",
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
