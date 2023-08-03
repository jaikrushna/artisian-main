import 'package:artisian/model/user.dart';
import 'package:artisian/view/landing.dart';
import 'package:artisian/view/userinfo.dart';
import 'package:artisian/viewmodel/course_view_model.dart';
import 'package:artisian/viewmodel/post_view_model.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:artisian/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:artisian/widget/profilepic.dart';

class RegistrationScreen extends StatefulWidget {
  String email;
  String passkey;
  RegistrationScreen({
    required this.email,
    required this.passkey,
  });
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();
  List<String> profilepic = [
    'https://firebasestorage.googleapis.com/v0/b/artisian-25b23.appspot.com/o/profilepic%2Fcat.jpg?alt=media&token=39fc452d-bcab-40ce-b87a-7880659c5f08',
    'https://firebasestorage.googleapis.com/v0/b/artisian-25b23.appspot.com/o/profilepic%2Fdeer.jpg?alt=media&token=136c2b91-64e4-4ecc-8d25-fbaad3b97c8d',
    'https://firebasestorage.googleapis.com/v0/b/artisian-25b23.appspot.com/o/profilepic%2Fdog.jpg?alt=media&token=2ad8c996-75d1-4c96-a8b4-f1014047c60c',
    'https://firebasestorage.googleapis.com/v0/b/artisian-25b23.appspot.com/o/profilepic%2Feagle.jpg?alt=media&token=4afb2cea-2b3d-4217-a000-8e3d228de1dd',
    'https://firebasestorage.googleapis.com/v0/b/artisian-25b23.appspot.com/o/profilepic%2Flion.jpg?alt=media&token=ed5f39ca-532c-4b0c-8856-c370caa26504',
    'https://firebasestorage.googleapis.com/v0/b/artisian-25b23.appspot.com/o/profilepic%2Fwolf.jpg?alt=media&token=acf232e4-81a1-4fdc-ad72-7d28fd97ff3e'
  ];
  String selectedAvatar = ''; // The default selected avatar
  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProfilePic(
                    imageUrl: profilepic[0],
                    onTap: () {
                      selectedAvatar = profilepic[0];
                      Navigator.pop(context);
                      setState(() {});
                    }),
                ProfilePic(
                    imageUrl: profilepic[1],
                    onTap: () {
                      selectedAvatar = profilepic[1];
                      Navigator.pop(context);
                      setState(() {});
                    }),
                ProfilePic(
                    imageUrl: profilepic[2],
                    onTap: () {
                      selectedAvatar = profilepic[2];
                      Navigator.pop(context);
                      setState(() {});
                    })
              ],
            ),
            Row(
              children: [
                ProfilePic(
                    imageUrl: profilepic[3],
                    onTap: () {
                      selectedAvatar = profilepic[3];
                      Navigator.pop(context);
                      setState(() {});
                    }),
                ProfilePic(
                    imageUrl: profilepic[4],
                    onTap: () {
                      selectedAvatar = profilepic[4];
                      Navigator.pop(context);
                      setState(() {});
                    }),
                ProfilePic(
                    imageUrl: profilepic[5],
                    onTap: () {
                      selectedAvatar = profilepic[5];
                      Navigator.pop(context);
                      setState(() {});
                    })
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    CourseViewModel courseModel = Provider.of<CourseViewModel>(context);
    PostViewModel postModel = Provider.of<PostViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  _showImagePickerBottomSheet();
                },
                child: CircleAvatar(
                  radius: 60,
                  child: Image.network(selectedAvatar),
                ),
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextFormField(
                controller: bioController,
                decoration: InputDecoration(labelText: 'Bio'),
              ),
              TextFormField(
                controller: hobbyController,
                decoration: InputDecoration(labelText: 'Hobby'),
              ),
              SizedBox(height: 16),
              custom_button(
                  width: size.width * 0.55,
                  email: widget.email,
                  passkey: widget.passkey,
                  selectedAvatar: selectedAvatar,
                  agetext: ageController.text,
                  hobbytext: hobbyController.text,
                  biotext: bioController.text,
                  nametext: nameController.text)
            ],
          ),
        ),
      ),
    );
  }
}
