import 'package:artisian/model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CourseViewModel extends ChangeNotifier {
  void addCourse({
    required String email,
    required String level,
  }) {
    Course course = Course(sub: Map(), vid: Map());
    FirebaseFirestore.instance
        .collection('course')
        .doc('${email}')
        .collection('${email}')
        .doc(level)
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

  Stream<int> getCourseValue(String level) async* {
    final currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser == null) {
      // If no authenticated user is found, yield 0.
      yield 0;
      return;
    }

    String? email = currentuser.email; // Get the email of the current user

    final beginnerDoc = await FirebaseFirestore.instance
        .collection('course')
        .doc(email)
        .collection('${email}')
        .doc(level)
        .get();

    Course? course = Course.fromSnapshot(beginnerDoc);
    int subCount = 0;
    int vidCount = 0;
    if (course != null) {
      // Get the count of 'vid' and 'sub' subfields with value true
      vidCount = course.countTrueValues('vid');
      subCount = course.countTrueValues('sub');

      // Print the counts (you can use them as needed)
      print('Number of true values in vid: $vidCount');
      print('Number of true values in sub: $subCount');
    }

    yield vidCount + subCount;
  }

  Future<void> updateFieldValue(String? level, String mapTodate,
      String fieldToUpdate, dynamic newValue) async {
    try {
      final currentuser = FirebaseAuth.instance.currentUser;
      if (currentuser == null) {
        // If no authenticated user is found, return early or handle the error accordingly.
        print('No authenticated user found.');
        return;
      }

      String? email = currentuser.email; // Get the email of the current user

      // Get the document reference for the specified level and user email
      DocumentReference<Map<String, dynamic>> documentRef = FirebaseFirestore
          .instance
          .collection('course')
          .doc(email)
          .collection(email!)
          .doc(level);

      // Get the current data from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await documentRef.get();
      if (!snapshot.exists) {
        print('Document not found for the given level: $level');
        return;
      }

      // Get the current data as a map
      Map<String, dynamic> data = snapshot.data() ?? {};

      // Choose the map to update (either 'vid' or 'sub') based on the input 'mapToUpdate'
      Map<String, dynamic> mapToUpdate =
          mapTodate == 'vid' ? data['vid'] ?? {} : data['sub'] ?? {};

      // Update the field in the mapToUpdate
      List<String> keys = fieldToUpdate.split('.');
      dynamic currentMap = mapToUpdate;
      for (int i = 0; i < keys.length - 1; i++) {
        currentMap = currentMap[keys[i]] ?? {};
      }
      currentMap[keys.last] = newValue;

      // Update the 'vid' or 'sub' map in Firestore with the updated data
      if (mapTodate == 'vid') {
        await documentRef.update({'vid': mapToUpdate});
      } else if (mapTodate == 'sub') {
        await documentRef.update({'sub': mapToUpdate});
      }

      // Optionally, you can notify the listeners about the successful update.
      notifyListeners();

      print('Field value updated successfully!');
    } catch (e) {
      print('Error updating field: $e');
      // Handle any error that occurred during the update process
    }
  }
}
