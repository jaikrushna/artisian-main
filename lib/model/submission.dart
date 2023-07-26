// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:artisian/model/customtile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Submission extends StatelessWidget {
  Submission({Key? key}) : super(key: key);
  String imageUrl = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GradientButton(
        imagePath: 'assets/images/my_image.png',
        title: 'Submission',
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
        ),
        onPressed: () async {
          showBottomSheet(context);
        },
        subtitle: '',
      ),
    );
  }
}

void showBottomSheet(BuildContext context) {
  String imageUrl = '';
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
                  _firestone.collection('post').doc('jb').collection('jb').add({
                    'imageURL': imageUrl,
                    'date': date,
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
                  _firestone.collection('post').doc('jb').collection('jb').add({
                    'imageURL': imageUrl,
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
