import 'package:artisian/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  void addUser({
    required String imageUrl,
    required String name,
    required int age,
    required String bio,
    required DateTime date,
    required String hobby,
    required String email,
    required int streak,
  }) {
    Users user = Users(
      imageUrl: imageUrl,
      name: name,
      age: age,
      bio: bio,
      date: date,
      hobby: hobby,
      email: email,
      streak: streak,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set(user.toMap())
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

  User? currentuser = FirebaseAuth.instance.currentUser;

  // Save the user data to Firestore

  Stream<Users?> getCurrentUserData(String? email) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // If no authenticated user is found, return an empty stream.
      return Stream.value(null);
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .snapshots()
        .map((documentSnapshot) {
      if (documentSnapshot.exists) {
        // Convert the document data to a Users object using the toUser function.
        return toUser(documentSnapshot.data());
      } else {
        // If the document does not exist, return null.
        return null;
      }
    });
  }

  Future<void> updateStreakAndDate(bool? step) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // If no authenticated user is found, return early or handle the error accordingly.
        print('No authenticated user found.');
        return;
      }

      String? email = currentUser.email; // Get the email of the current user

      // Get the document reference for the current user
      DocumentReference<Map<String, dynamic>> documentRef =
          FirebaseFirestore.instance.collection('users').doc(email);

      // Get the user's data
      DocumentSnapshot<Map<String, dynamic>> snapshot = await documentRef.get();
      if (!snapshot.exists) {
        print('User document not found for email: $email');
        return;
      }

      // Get the current data as a map
      Map<String, dynamic> data = snapshot.data() ?? {};

      // Get the stored date from the data
      DateTime storedDate = (data['date'] as Timestamp).toDate();

      // Get the current date
      DateTime currentDate = DateTime.now();
      int dateDifference = currentDate.difference(storedDate).inDays;
      // Check if the difference between the stored date and the current date is 1 day
      if (1 <= dateDifference && dateDifference <= 3 && step!) {
        // Increment the streak by 1 and update the date to the current date
        int newStreak = (data['streak'] ?? 0) + 1;
        await documentRef.update({
          'streak': newStreak,
          'date': FieldValue.serverTimestamp(),
          // Update the date to the current date and time
        });

        // Optionally, you can notify the listeners about the successful update.
        notifyListeners();

        print('Streak incremented and date updated successfully!');
      } else if (dateDifference <= 0 && !step!) {
        // Decrement the streak by 1 and update the date to the current date
        int newStreak = (data['streak'] ?? 0) - 1;
        await documentRef.update({
          'streak': newStreak >= 0 ? newStreak : 0,
          'date': FieldValue.serverTimestamp(),
        });

        notifyListeners();

        print('Streak decremented and date updated successfully!');
      } else {
        print(
            'Date difference is not equal to 1 day, streak remains unchanged.');
      }
    } catch (e) {
      print('Error updating streak and date: $e');
    }
  }

  Future<void> updateUserProfile({
    required String imageUrl,
    required String name,
    required String hobby,
    required String bio,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('No authenticated user found.');
        return;
      }

      String? email = currentUser.email; // Get the email of the current user

      // Get the document reference for the current user
      DocumentReference<Map<String, dynamic>> documentRef =
          FirebaseFirestore.instance.collection('users').doc(email);

      // Update the user's profile fields
      await documentRef.update({
        'imageUrl': imageUrl,
        'name': name,
        'hobby': hobby,
        'bio': bio,
      });

      // Optionally, you can notify the listeners about the successful update.
      notifyListeners();

      print('User profile updated successfully!');
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }
}
