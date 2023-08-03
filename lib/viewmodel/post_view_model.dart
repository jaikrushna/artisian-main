import 'package:artisian/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostViewModel extends ChangeNotifier {
  void PostNew({
    required String? email,
  }) {
    Post post = Post(imageUrl: '', date: DateTime.now());
    FirebaseFirestore.instance
        .collection('post')
        .doc('${email}')
        .collection('${email}')
        .add(post.toMap())
        .then((value) {
      // Data saved successfully
      // Show a success message or navigate to another screen
      print('Post data saved successfully!');
      // You can notify the listeners about success.
      notifyListeners();
    }).catchError((error) {
      // Error occurred while saving data
      print('Error saving Post data: $error');
      // You can notify the listeners about the error.
      notifyListeners();
    });
  }

  void addPost({
    required String? email,
    required String imageUrl,
  }) {
    Post post = Post(imageUrl: imageUrl, date: DateTime.now());
    FirebaseFirestore.instance
        .collection('post')
        .doc('${email}')
        .collection('${email}')
        .add(post.toMap())
        .then((value) {
      // Data saved successfully
      // Show a success message or navigate to another screen
      print('Post data saved successfully!');
      // You can notify the listeners about success.
      notifyListeners();
    }).catchError((error) {
      // Error occurred while saving data
      print('Error saving Post data: $error');
      // You can notify the listeners about the error.
      notifyListeners();
    });
  }

  // Save the Post data to Firestore
  static Post? toPost(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.exists) {
      final data = doc.data();
      return Post(
        imageUrl: data!['imageUrl'],
        date: DateTime.fromMillisecondsSinceEpoch(
            data['date'].millisecondsSinceEpoch),
      );
    } else {
      return null;
    }
  }

  User? currentuser = FirebaseAuth.instance.currentUser;
  // Save the user data to Firestore

  Stream<Post?> getCurrentPostData() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // If no authenticated user is found, return an empty stream.
      return Stream.value(null);
    }
    String? email = currentuser?.email;
    return FirebaseFirestore.instance
        .collection('post')
        .doc('${email}')
        .collection('${email}')
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there is only one document for each user
        return toPost(querySnapshot.docs.first);
      } else {
        return null;
      }
    });
  }
}
