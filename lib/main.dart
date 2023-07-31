import 'package:artisian/auth/signup_screen.dart';
import 'package:artisian/view/syllabus.dart';
import 'package:artisian/viewmodel/course_view_model.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:artisian/view/youtube.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => EmailViewModel()),
          ChangeNotifierProvider(create: (context) => CourseViewModel()),
          ChangeNotifierProvider(create: (context) => UserViewModel()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: Login_View(),
          // initialRoute: '/home',
          routes: {
            '/syllabus': (context) => Syllabus(
                  level: '',
                ),
            '/youtube': (context) => Youtube_screen(),
            // Add more routes as needed
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
        ));
  }
}
