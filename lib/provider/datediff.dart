import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> calculateDaysDifference(String? userId) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userId)
            .get();

    if (snapshot.exists &&
        snapshot.data() != null &&
        snapshot.data()!.containsKey('date')) {
      final Timestamp dateFromFirestore =
          snapshot.data()!['date'] as Timestamp;

      final DateTime dateInFirestore = dateFromFirestore.toDate();

      final DateTime currentDate = DateTime.now();

      final int differenceInDays =
          currentDate.difference(dateInFirestore).inDays;

      return differenceInDays;
    } else {
      return -1; // Use any value that represents the error case or a default value.
    }
  } catch (e) {
    print('Error calculating days difference: $e');
    return -1; // Use any value that represents the error case or a default value.
  }
}
