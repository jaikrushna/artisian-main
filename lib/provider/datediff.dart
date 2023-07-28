import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> calculateDaysDifference(String userId) async {
  try {
    // Fetch the document from Firestore.
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('your_collection_name')
            .doc(userId)
            .get();

    // Check if the document exists and contains the date field.
    if (snapshot.exists &&
        snapshot.data() != null &&
        snapshot.data()!.containsKey('your_date_field')) {
      // Get the date stored in Firestore as a Timestamp.
      final Timestamp dateFromFirestore =
          snapshot.data()!['your_date_field'] as Timestamp;

      // Convert the Timestamp to a DateTime.
      final DateTime dateInFirestore = dateFromFirestore.toDate();

      // Get the current date and time.
      final DateTime currentDate = DateTime.now();

      // Calculate the difference between the two dates in days.
      final int differenceInDays =
          currentDate.difference(dateInFirestore).inDays;

      return differenceInDays;
    } else {
      // Handle the case when the document does not exist or does not contain the date field.
      // You can return a default value or show an error message.
      return -1; // Use any value that represents the error case or a default value.
    }
  } catch (e) {
    print('Error calculating days difference: $e');
    // Handle the error case and return a default value or show an error message.
    return -1; // Use any value that represents the error case or a default value.
  }
}
