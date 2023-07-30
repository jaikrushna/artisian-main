import 'package:artisian/model/user.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserViewModel viewModel = Provider.of<UserViewModel>(context);

    return StreamBuilder<Users?>(
      stream: viewModel.getCurrentUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error fetching user data: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        Users? user = snapshot.data;
        if (user == null) {
          return Text('User data not found.');
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${user.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Age: ${user.age}'),
            SizedBox(height: 8),
            Text('Bio: ${user.bio}'),
            SizedBox(height: 8),
            Text('Date: ${user.date.toLocal().toString()}'),
            SizedBox(height: 8),
            Text('Hobby: ${user.hobby}'),
            SizedBox(height: 8),
            Text('Email: ${user.email}'),
            SizedBox(height: 8),
            Text('Streak: ${user.streak}'),
          ],
        );
      },
    );
  }
}
