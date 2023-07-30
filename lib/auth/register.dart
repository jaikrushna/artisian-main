import 'package:artisian/model/user.dart';
import 'package:artisian/view/userinfo.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController streakController = TextEditingController();

//   void addUserToFirestore() {
//     String name = nameController.text;
//     int age = int.parse(ageController.text);
//     String bio = bioController.text;
//     DateTime date = DateTime.parse(dateController.text);
//     String hobby = hobbyController.text;
//     String email = emailController.text;
//     int streak = int.parse(streakController.text);

//     User user = User(
//       name: name,
//       age: age,
//       bio: bio,
//       date: date,
//       hobby: hobby,
//       email: email,
//       streak: streak,
//     );

//     // Save the user data to Firestore
//     FirebaseFirestore.instance
//         .collection('users')
//         .add(user.toMap())
//         .then((value) {
//       // Data saved successfully
//       // Show a success message or navigate to another screen
//       print('User data saved successfully!');
//       // You can navigate to another screen here if needed.
//     }).catchError((error) {
//       // Error occurred while saving data
//       print('Error saving user data: $error');
//     });
//   }

  @override
  Widget build(BuildContext context) {
    UserViewModel viewModel = Provider.of<UserViewModel>(context);

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
                controller: dateController,
                decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              ),
              TextFormField(
                controller: hobbyController,
                decoration: InputDecoration(labelText: 'Hobby'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: streakController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Streak'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  DateTime date = DateTime.parse(dateController.text);
                  int age = int.tryParse(ageController.text) ?? 0;
                  int streak = int.tryParse(streakController.text) ?? 0;
                  viewModel.addUser(
                    name: nameController.text,
                    age: age,
                    bio: bioController.text,
                    date: date,
                    hobby: hobbyController.text,
                    email: emailController.text,
                    streak: streak,
                  );
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => UserInfoWidget()));
                },
                child: Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
