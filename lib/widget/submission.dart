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
        height: size.height * 0.09,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
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
                  Column(
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
                    ],
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
                  await referenceImageToUpload.putFile(File(file.path));
                  Navigator.of(context).pop();
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
                  Navigator.of(context).pop();
                  await referenceImageToUpload.putFile(File(file.path));
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
                  //Some error occurred
                }
              },
            ),
          ],
        );
      },
    );
  }
}
