import 'package:artisian/auth/login_screen.dart';
import 'package:artisian/model/user.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class App_Drawer extends StatefulWidget {
  @override
  State<App_Drawer> createState() => _App_DrawerState();
}

class _App_DrawerState extends State<App_Drawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    EmailViewModel emailModel = Provider.of<EmailViewModel>(context);
    String? email = emailModel.userEmail;
    bool toggleValue1 = false;
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
                ListTile(
                  title: Text("Dark Mode"),
                  // trailing: FlutterSwitch(
                  //   activeColor: Color(0xff1E8829),
                  //   inactiveColor: Color(0xff1E8829),
                  //   width: size.width * 0.07,
                  //   height: size.height * 0.018,
                  //   valueFontSize: size.height * 0.018,
                  //   toggleSize: size.height * 0.018,
                  //   value: toggleValue1,
                  //   borderRadius: 30.0,
                  //   // padding: 8.0,
                  //   showOnOff: false,
                  //   onToggle: (val) {
                  //     setState(() {
                  //       if (val == true) {
                  //         toggleValue1 = val;
                  //       } else {
                  //         toggleValue1 = val;
                  //       }
                  //     });
                  //   },
                  // ),
                ),
                Divider(),
                TextButton(
                  child: ListTile(
                    title: Text("Log Out"),
                    trailing: Icon(
                      Icons.logout,
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login_Screen()));
                  },
                ),
              ],
            );
          }),
    );
  }
}
