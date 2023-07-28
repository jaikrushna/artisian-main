import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final int age;
  final String bio;
  final Timestamp date;
  final String hobby;
  final String email;
  final int streak;

  User({
    required this.name,
    required this.age,
    required this.bio,
    required this.date,
    required this.hobby,
    required this.email,
    required this.streak,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      bio: map['bio'] ?? '',
      date: map['date'] ?? DateTime.timestamp(),
      hobby: map['hobby'] ?? '',
      email: map['email'] ?? '',
      streak: map['streak'] ?? 0,
    );
  }
}
