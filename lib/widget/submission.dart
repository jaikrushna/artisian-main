// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:artisian/provider/TickButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:provider/provider.dart';
import '../viewmodel/post_view_model.dart';

class Submission extends StatefulWidget {
  static const route = '/submission';
  late bool? isTicked;
  late String field;
  late String? level;
  Submission({
    required this.isTicked,
    required this.field,
    required this.level,
  });

  @override
  State<Submission> createState() => _SubmissionState();
}

class _SubmissionState extends State<Submission> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              showBottomSheet2(user!.email);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  TickButton(
                    isTicked: widget.isTicked,
                    userEmail: user!.email,
                    field: widget.field,
                    level: widget.level,
                    mapname: 'sub',
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submission',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
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
    final _firestone = FirebaseFirestore.instance;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.camera);
                  print('${file?.path}');

                  if (file == null) return;
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images/');

                  Reference referenceImageToUpload =
                      referenceDirImages.child('${uniqueFileName}');

                  try {
                    await referenceImageToUpload.putFile(File(file.path));
                    Navigator.of(context).pop();
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                    FirebaseFirestore.instance
                        .collection('post')
                        .doc('${email}')
                        .collection('${email}')
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
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  print('${file?.path}');

                  if (file == null) return;
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images/');

                  Reference referenceImageToUpload =
                      referenceDirImages.child('${uniqueFileName}');

                  try {
                    await referenceImageToUpload.putFile(File(file.path));
                    Navigator.of(context).pop();
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                    _firestone
                        .collection('post')
                        .doc('${email}')
                        .collection('${email}')
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
          ),
        );
      },
    );
  }
}
