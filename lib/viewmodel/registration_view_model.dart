import 'package:artisian/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  void addUser({
    required String name,
    required int age,
    required String bio,
    required DateTime date,
    required String hobby,
    required String email,
    required int streak,
  }) {
    Users user = Users(
      name: name,
      age: age,
      bio: bio,
      date: date,
      hobby: hobby,
      email: email,
      streak: streak,
    );
    User? currentuser = FirebaseAuth.instance.currentUser;

// Stream<Users?> getCurrentUser() {
//   final currentUser = FirebaseAuth.instance.currentUser;
//   if (currentUser == null) {
//     // If no authenticated user is found, return an empty stream.
//     return Stream.value(null);
//   }

//   return FirebaseFirestore.instance
//       .collection('users')
//       .doc(currentUser.uid)
//       .collection("userinfo")
//       .snapshots()
//       .map((querySnapshot) {
//     if (querySnapshot.docs.isNotEmpty) {
//       // Assuming there is only one document for each user
//       return toUser(querySnapshot.docs.first);
//     } else {
//       return null;
//     }
//   });
// }

    // Save the user data to Firestore
    void addUser({
      required String name,
      required int age,
      required String bio,
      required DateTime date,
      required String hobby,
      required String email,
      required int streak,
    }) {
      FirebaseFirestore.instance
          .collection('users')
          
          .add(user.toMap())
          .then((value) {
        // Data saved successfully
        // Show a success message or navigate to another screen
        print('User data saved successfully!');
        // You can notify the listeners about success.
        notifyListeners();
      }).catchError((error) {
        // Error occurred while saving data
        print('Error saving user data: $error');
        // You can notify the listeners about the error.
        notifyListeners();
      });
    }
  }

  Stream<Users?> getCurrentUserData() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // If no authenticated user is found, return an empty stream.
      return Stream.value(null);
    }

    return FirebaseFirestore.instance
        .collection('users')
        
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there is only one document for each user
        return toUser(querySnapshot.docs.first);
      } else {
        return null;
      }
    });
  }
}
