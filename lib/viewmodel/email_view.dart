import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailViewModel with ChangeNotifier {
  String? _userEmail;
  String? get userEmail => _userEmail;

  EmailViewModel() {
    fetchUserEmail();
  }

  Future<void> fetchUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _userEmail = 'jai11@gmail.com'; //user.email;
        notifyListeners();
      }
    } catch (error) {
      print("Error fetching user email: $error");
    }
  }
}
