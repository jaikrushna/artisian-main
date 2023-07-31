import 'package:artisian/model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CourseViewModel extends ChangeNotifier {
  void addCourse({
    required String email,
  }) {
    Course course = Course(sub: Map(), vid: Map());
    FirebaseFirestore.instance
        .collection('course')
        .doc('${email}')
        .collection('${email}')
        .doc('Beginner')
        .set(course.toMap())
        .then((value) {
      // Data saved successfully
      // Show a success message or navigate to another screen
      print('Course data saved successfully!');
      // You can notify the listeners about success.
      notifyListeners();
    }).catchError((error) {
      // Error occurred while saving data
      print('Error saving Course data: $error');
      // You can notify the listeners about the error.
      notifyListeners();
    });
  }

  User? currentuser = FirebaseAuth.instance.currentUser;
  // Save the Course data to Firestore

  Future<Course?> getCurrentCourseData(String level) async {
    final currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser == null) {
      // If no authenticated user is found, return null.
      return null;
    }

    String? email = currentuser.email; // Get the email of the current user

    final beginnerDoc = await FirebaseFirestore.instance
        .collection('course')
        .doc(email)
        .collection('${email}')
        .doc(level)
        .get();

    return Course.fromSnapshot(beginnerDoc);
  }
}
