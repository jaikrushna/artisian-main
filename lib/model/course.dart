class Course {
  final bool sub1;
  final bool vid1;
  final bool sub2;
  final bool vid2;
  final bool sub3;
  final bool vid3;
  final bool sub4;
  final bool vid4;
  final bool sub5;
  final bool vid5;

  Course({
    required this.sub1,
    required this.vid1,
    required this.sub2,
    required this.vid2,
    required this.sub3,
    required this.vid3,
    required this.sub4,
    required this.vid4,
    required this.sub5,
    required this.vid5,
  });

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      sub1: map['sub1'] ?? false,
      vid1: map['vid1'] ?? false,
      sub2: map['sub2'] ?? false,
      vid2: map['vid2'] ?? false,
      sub3: map['sub3'] ?? false,
      vid3: map['vid3'] ?? false,
      sub4: map['sub4'] ?? false,
      vid4: map['vid4'] ?? false,
      sub5: map['sub5'] ?? false,
      vid5: map['vid5'] ?? false,
    );
  }
}
