import 'package:artisian/model/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class CourseViewModel with ChangeNotifier {
  Course? _customModel;
  Course? get customModel => _customModel;
  Future<Course?> fetchDocumentData(String? email, String docID) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('course')
          .doc('${email}')
          .collection('${email}')
          .doc('${docID}')
          .get();

      if (documentSnapshot.exists) {
        _customModel =
            Course.fromMap(documentSnapshot.data() as Map<String, dynamic>);
        notifyListeners();
      }
      return null;
    } catch (error) {
      print("Error fetching document data: $error");
    }
  }
}
