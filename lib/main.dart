import 'package:artisian/auth/signup_screen_new.dart';
import 'package:artisian/view/syllabus.dart';
import 'package:artisian/viewmodel/course_view_model.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:artisian/widget/submission.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:artisian/view/youtube.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:provider/provider.dart';
import 'package:artisian/viewmodel/post_view_model.dart';

import 'view/landing.dart';

Widget isLogin() {
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return LoginView();
  } else
    return Landing();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => EmailViewModel()),
      ChangeNotifierProvider(create: (context) => CourseViewModel()),
      ChangeNotifierProvider(create: (context) => PostViewModel()),
      ChangeNotifierProvider(create: (context) => UserViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLogin(),
      // initialRoute: '/home',
      routes: {
        '/syllabus': (context) => Syllabus(
              level: '',
            ),
        '/youtube': (context) => Youtube_screen(),
        '/submission': (context) =>
            Submission(isTicked: false, field: '', level: '')
      },
      onGenerateRoute: (settings) {
        // Widget page;
        switch (settings.name) {
          case '/home':
            // page = HomePage();
            break;
          case '/search':
            // page = SearchPage();
            break;
          case '/settings':
            // page = SettingsPage();
            break;
          default:
          // page = HomePage();
        }
        return null;
        // return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}
