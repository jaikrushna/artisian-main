// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';
import 'package:artisian/widget/TickButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Submission extends StatefulWidget {
  static const route = '/submission';
  late bool? isTicked;
  late String field;
  late String? level;
  Submission({
    Key? key,
    required this.isTicked,
    required this.field,
    required this.level,
  }) : super(key: key);

  @override
  State<Submission> createState() => _SubmissionState();
}

class _SubmissionState extends State<Submission> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.022), //8
      child: Container(
        height: size.height * 0.11,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.withOpacity(0.30), // 50% transparent blue
              Colors.deepPurple.withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(size.height * 0.011), //8
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              showBottomSheet2(user!.email);
            },
            child: Padding(
              padding: EdgeInsets.all(size.height * 0.022), //16
              child: Row(
                children: [
                  TickButton(
                    isTicked: widget.isTicked,
                    userEmail: user!.email,
                    field: widget.field,
                    level: widget.level,
                    mapname: 'sub',
                  ),
                  SizedBox(width: size.width * 0.03), //8
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Submission',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.042, //16
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '(Create a sketch based on the concepts discussed above)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.028, //16
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet2(String? email) {
    String imageUrl;
    String date = DateTime.now().toString();
    final firestone = FirebaseFirestore.instance;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.camera);

                if (file == null) return;
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images/');

                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                try {
                  UploadTask uploadTask =
                      referenceImageToUpload.putFile(File(file.path));
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      double uploadProgress = 0.0; // Initialize progress
                      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
                        uploadProgress =
                            snapshot.bytesTransferred / snapshot.totalBytes;
                        // Update the progress using the snapshot's data
                      });

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Center(
                                child: Text('Uploading sketch...')),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                    value: uploadProgress),
                                const SizedBox(height: 10),
                                Image.asset('assets/icons/loading.gif')
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Submission Successful'),
                        content: const Text(
                            'Your submission has been successfully uploaded.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  FirebaseFirestore.instance
                      .collection('post')
                      .doc('$email')
                      .collection('$email')
                      .add({
                    'imageUrl': imageUrl,
                    'date': DateTime.now(),
                  });
                } catch (error) {
                  //Some error occurred
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);

                if (file == null) return;
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('images/');

                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                try {
                  UploadTask uploadTask =
                      referenceImageToUpload.putFile(File(file.path));
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      double uploadProgress = 0.0; // Initialize progress
                      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
                        uploadProgress =
                            snapshot.bytesTransferred / snapshot.totalBytes;
                        // Update the progress using the snapshot's data
                      });

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Center(
                                child: Text('Uploading sketch...')),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                    value: uploadProgress),
                                const SizedBox(height: 10),
                                Image.asset('assets/icons/loading.gif')
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Submission Successful'),
                        content: const Text(
                            'Your submission has been successfully uploaded.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  firestone
                      .collection('post')
                      .doc('$email')
                      .collection('$email')
                      .add({
                    'imageUrl': imageUrl,
                    'date': date,
                  });
                } catch (error) {
                  // Handle the error
                  print('Error: $error');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
