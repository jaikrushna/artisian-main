import 'package:artisian/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class UserViewModel with ChangeNotifier {
  User? _customModel;
  User? get customModel => _customModel;

  UserViewModel(String email, String docID) {
    fetchDocumentData(email, docID);
  }

  Future<void> fetchDocumentData(String email, String docID) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc('${email}')
          .collection('${email}')
          .doc('${docID}')
          .get();

      if (documentSnapshot.exists) {
        _customModel =
            User.fromMap(documentSnapshot.data() as Map<String, dynamic>);
        notifyListeners();
      }
    } catch (error) {
      print("Error fetching document data: $error");
    }
  }
}
