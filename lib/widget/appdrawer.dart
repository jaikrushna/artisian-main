// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:artisian/auth/login_screen.dart';
import 'package:artisian/model/user.dart';
import 'package:artisian/provider/theme_provider.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class App_Drawer extends StatefulWidget {
  const App_Drawer({Key? key}) : super(key: key);

  @override
  State<App_Drawer> createState() => _App_DrawerState();
}

class _App_DrawerState extends State<App_Drawer> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    EmailViewModel emailModel = Provider.of<EmailViewModel>(context);
    String? email = emailModel.userEmail;
    final theme = Theme.of(context);
    return Drawer(
      child: StreamBuilder<Users?>(
          stream: viewModel.getCurrentUserData(email),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error fetching user data: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            Users? user = snapshot.data;
            if (user == null) {
              return const Text('User data not found.');
            }
            return WillPopScope(
              onWillPop: () async {
                // Disable back button
                return false;
              },
              child: Column(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusScope.of(context)
                          .unfocus(); // Close the keyboard when tapping outside the drawer
                    },
                    child: AppBar(
                      backgroundColor: theme.backgroundColor,
                      toolbarHeight: size.height * 0.280, //200
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.08),
                            child: user.imageUrl == ""
                                ? Image.asset(
                                    "assets/icons/logo.png",
                                    width: size.width * 0.38, //30
                                    height: size.height * 0.210,
                                  )
                                : Image.network(
                                    user.imageUrl,
                                    width: size.width * 0.38, //30
                                    height: size.height * 0.210,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(
                            width: size.width * 0.038,
                          ),
                          Flexible(
                            child: Text(
                              user.name,
                              style: TextStyle(
                                color: theme.focusColor,
                                fontSize: size.width * 0.045,
                              ),
                            ),
                          ),
                        ],
                      ),
                      automaticallyImplyLeading: false,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Dark Mode"),
                    trailing: Switch(
                      activeColor: const Color(0xff1E8829),
                      value: themeProvider.themeMode ==
                          ThemeMode.dark, // Use the bool value here
                      onChanged: (val) {
                        ThemeMode newThemeMode =
                            val ? ThemeMode.dark : ThemeMode.light;
                        themeProvider.setThemeMode(newThemeMode);
                      },
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    child: ListTile(
                      title: const Text("Log Out"),
                      trailing: Icon(
                        Icons.logout,
                        color: theme.focusColor,
                      ),
                    ),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Login_Screen()), // Make sure the class name is correctly written as "SignupScreen"// Remove all previous routes from the stack
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
