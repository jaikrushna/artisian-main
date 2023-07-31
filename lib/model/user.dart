import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String name;
  final int age;
  final String bio;
  final DateTime date;
  final String hobby;
  final String email;
  final int streak;
  final String imageUrl;
  Users({
    required this.imageUrl,
    required this.name,
    required this.age,
    required this.bio,
    required this.date,
    required this.hobby,
    required this.email,
    required this.streak,
  });
  Map<String, dynamic> toMap() {
    return {
      "imageUrl": imageUrl,
      "name": name,
      "age": age,
      "bio": bio,
      "date": date,
      "hobby": hobby,
      "email": email,
      "streak": streak,
    };
  }

  static List<Users> fromQuery(QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.isNotEmpty ? toUsers(snapshot) : [];
}

List<Users> toUsers(QuerySnapshot<Map<String, dynamic>> query) =>
    query.docs.map((doc) => toUser(doc)).whereType<Users>().toList();

Users? toUser(DocumentSnapshot<Map<String, dynamic>> doc) => doc.exists
    ? Users(
        imageUrl: doc.data()!["imageUrl"],
        name: doc.data()!["name"],
        age: doc.data()!["age"],
        bio: doc.data()!["bio"],
        date: doc.data()!["date"],
        hobby: doc.data()!["hobby"],
        email: doc.data()!["email"],
        streak: doc.data()!["streak"],
      )
    : null;
