import 'package:cloud_firestore/cloud_firestore.dart';

void incrementField(String? email) {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('user');
  String fieldName = 'streak';
  collection.doc('${email}').update({
    fieldName: FieldValue.increment(1),
  });
}

void decrementField(String? email) {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('user');
  String fieldName = 'streak';
  collection.doc('${email}').update({
    fieldName: FieldValue.increment(-1),
  });
}
