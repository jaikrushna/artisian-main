import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String imageUrl;
  DateTime date;

  Post({
    required this.imageUrl,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'date': date,
    };
  }

  static List<Post> fromQuery(QuerySnapshot<Map<String, dynamic>> snapshot) =>
      snapshot.docs.isNotEmpty ? toPost(snapshot) : [];
}

List<Post> toPost(QuerySnapshot<Map<String, dynamic>> query) =>
    query.docs.map((doc) => _toPost(doc)).whereType<Post>().toList();

Post? _toPost(DocumentSnapshot<Map<String, dynamic>> doc) => doc.exists
    ? Post(
        imageUrl: doc.data()!["imageUrl"],
        date: doc.data()!["date"],
      )
    : null;
