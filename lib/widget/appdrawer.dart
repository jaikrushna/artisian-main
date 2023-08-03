import 'package:artisian/model/user.dart';
import 'package:artisian/view/anotheraccount.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class App_Drawer extends StatefulWidget {
  @override
  State<App_Drawer> createState() => _App_DrawerState();
}

class _App_DrawerState extends State<App_Drawer> {
  @override
  Widget build(BuildContext context) {
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    EmailViewModel emailModel = Provider.of<EmailViewModel>(context);
    String? email = emailModel.userEmail;
    return Drawer(
      child: StreamBuilder<Users?>(
          stream: viewModel.getCurrentUserData(email),
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
              children: [
                AppBar(
                  toolbarHeight: 200,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          user.imageUrl,
                          width: 155,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Text(
                          user.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  automaticallyImplyLeading: false,
                ),
                Divider(),
                TextButton(
                  child: ListTile(
                    title: Text("Dark Mode"),
                    trailing: Icon(
                      Icons.toggle_off_rounded,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
                Divider(),
                TextButton(
                  child: ListTile(
                    title: Text("Log Out"),
                    trailing: Icon(
                      Icons.logout,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.pushReplacementNamed('/');
                    Provider.of(context, listen: false).logout();
                    // Navigator.of(context)
                    //     .pushReplacementNamed(User_product_screen.routee);
                  },
                ),
              ],
            );
          }),
    );
  }
}
