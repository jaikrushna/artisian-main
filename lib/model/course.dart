import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final Map<String, bool> sub;
  final Map<String, bool> vid;

  Course({
    required this.sub,
    required this.vid,
  });

  Map<String, dynamic> toMap() {
    return {
      'sub': {
        'sub1': sub['sub1'] ?? false,
        'sub2': sub['sub2'] ?? false,
        'sub3': sub['sub3'] ?? false,
        'sub4': sub['sub4'] ?? false,
        'sub5': sub['sub5'] ?? false,
      },
      'vid': {
        'vid1': vid['vid1'] ?? false,
        'vid2': vid['vid2'] ?? false,
        'vid3': vid['vid3'] ?? false,
        'vid4': vid['vid4'] ?? false,
        'vid5': vid['vid5'] ?? false,
      },
    };
  }

  static Course? fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists) {
      final data = snapshot.data();
      return Course(
        sub: Map<String, bool>.from(data!['sub']),
        vid: Map<String, bool>.from(data!['vid']),
      );
    } else {
      return null;
    }
  }

  int countTrueValues(String mapName) {
    int count = 0;
    Map<String, bool>? map;
    if (mapName == 'sub') {
      map = sub;
    } else if (mapName == 'vid') {
      map = vid;
    }

    if (map != null) {
      map.forEach((key, value) {
        if (value) {
          count++;
        }
      });
    }

    return count;
  }
}
