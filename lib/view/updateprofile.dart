// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:artisian/helper/custom_text_field.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:artisian/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:artisian/widget/profilepic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatefulWidget {
  String email;
  UpdateScreen({
    Key? key,
    required this.email,
  }) : super(key: key);
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
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
        Size size = MediaQuery.of(context).size;
        return SizedBox(
          height: size.height * 0.48,
          child: Column(
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Center(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios))),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.130), //57
          child: Image.asset(
            "assets/icons/logo.png",
            height: size.height * 0.18, //140
          ),
        ),
        backgroundColor: const Color(0xff101A30),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.022),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _showImagePickerBottomSheet();
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(size.width * 0.055),
                    child: Card(
                      elevation: 6,
                      child: selectedAvatar == ''
                          ? Image.asset(
                              'assets/icons/select.png',
                              fit: BoxFit.fill,
                              height: size.height * 0.20, //170
                              width: size.width * 0.45, //170
                            )
                          : Image.network(
                              selectedAvatar,
                              fit: BoxFit.fill,
                              height: size.height * 0.23, //170
                              width: size.width * 0.47,
                            ),
                    )),
              ),
              TextButton(
                onPressed: () {
                  _showImagePickerBottomSheet();
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.27,
                    ),
                    const Center(child: Icon(Icons.add_a_photo)),
                    SizedBox(
                      width: size.width * 0.030,
                    ),
                    const Center(
                      child: Text(
                        'Pick an Avatar',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.023,
              ),
              Container(
                height: size.height * 0.078, //66
                width: size.width * 0.90,
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: nameController,
                  decoration: ThemeHelper()
                      .textInputDecoration('Name ', 'Enter your name'),
                  style: TextStyle(fontSize: size.width * 0.042),
                ),
              ),
              SizedBox(
                height: size.height * 0.016,
              ),
              Container(
                height: size.height * 0.078, //66
                width: size.width * 0.90,
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration:
                      ThemeHelper().textInputDecoration('Enter your Age'),
                  style: TextStyle(fontSize: size.width * 0.042),
                ),
              ),
              SizedBox(
                height: size.height * 0.016,
              ),
              Container(
                height: size.height * 0.078, //66
                width: size.width * 0.90,
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: bioController,
                  decoration: ThemeHelper()
                      .textInputDecoration('Enter Bio ( Any Quote )'),
                  style: TextStyle(fontSize: size.width * 0.042),
                ),
              ),
              SizedBox(
                height: size.height * 0.016,
              ),
              Container(
                height: size.height * 0.078, //66
                width: size.width * 0.90,
                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: hobbyController,
                  decoration: ThemeHelper()
                      .textInputDecoration('Enter a Hobby (any one)'),
                  style: TextStyle(fontSize: size.width * 0.042),
                ),
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              SizedBox(
                height: size.height * 0.065,
                width: size.width * 0.34,
                child: ElevatedButton(
                  onPressed: () {
                    // Example: Update user profile
                    viewModel.updateUserProfile(
                      imageUrl: selectedAvatar,
                      name: nameController.text,
                      age: int.parse(ageController.text),
                      hobby: hobbyController.text,
                      bio: bioController.text,
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height * 0.030),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Update",
                        style: GoogleFonts.poppins(
                            fontSize: size.height * 0.020,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      const Icon(Icons.arrow_forward_ios_sharp,
                          color: Colors.black),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
