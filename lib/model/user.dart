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
    query.docs.map((doc) => toUser(doc.data())).whereType<Users>().toList();

Users? toUser(Map<String, dynamic>? data) {
  if (data != null) {
    return Users(
      imageUrl: data["imageUrl"],
      name: data["name"],
      age: data["age"],
      bio: data["bio"],
      date: (data["date"] as Timestamp).toDate(),
      hobby: data["hobby"],
      email: data["email"],
      streak: data["streak"],
    );
  } else {
    return null;
  }
}
