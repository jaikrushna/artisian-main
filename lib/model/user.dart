import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String name;
  final int age;
  final String bio;
  final DateTime date;
  final String hobby;
  final String email;
  final int streak;

  Users({
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
      "name": name,
      "age": age,
      "bio": bio,
      "date": DateTime.timestamp(),
      "hobby": hobby,
      "email": email,
      "streak": streak,
    };
  }

  static List<Users> fromQuery(QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.isNotEmpty ? toUsers(snapshot) : [];

  // factory User.fromMap(Map<String, dynamic> map) {
  //   return User(
  //     name: map['name'] ?? '',
  //     age: map['age'] ?? 0,
  //     bio: map['bio'] ?? '',
  //     date: map['date'] ?? DateTime.timestamp(),
  //     hobby: map['hobby'] ?? '',
  //     email: map['email'] ?? '',
  //     streak: map['streak'] ?? 0,
  //   );
  // }
}

List<Users> toUsers(QuerySnapshot<Map<String, dynamic>> query) =>
    query.docs.map((doc) => toUser(doc)).whereType<Users>().toList();

Users? toUser(DocumentSnapshot<Map<String, dynamic>> doc) => doc.exists
    ? Users(
        name: doc.data()!["name"],
        age: doc.data()!["age"],
        bio: doc.data()!["bio"],
        date: DateTime.fromMicrosecondsSinceEpoch(doc.data()!['date'] ?? 0),
        hobby: doc.data()!["hobby"],
        email: doc.data()!["email"],
        streak: doc.data()!["streak"],
      )
    : null;
