import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailViewModel with ChangeNotifier {
  String? userEmail;

  EmailViewModel() {
    fetchUserEmail();
  }

  Future<void> fetchUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Perform any additional validation checks on the email if required
        userEmail = user.email;
        notifyListeners();
      } else {
        // Handle the case when no authenticated user is found
        userEmail = null;
        notifyListeners();
      }
    } catch (error) {
      print("Error fetching user email: $error");
      // Handle the error while fetching the email
      userEmail = null;
      notifyListeners();
    }
  }
}
