import 'package:artisian/model/completion.dart';
import 'package:artisian/model/customtile.dart';
import 'package:artisian/model/submission.dart';
import 'package:flutter/material.dart';
import 'package:artisian/view/youtube.dart';

class Syllabus extends StatefulWidget {
  static const route = '/syllabus';
  const Syllabus({Key? key}) : super(key: key);

  @override
  State<Syllabus> createState() => _SyllabusState();
}

class _SyllabusState extends State<Syllabus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Completion(),
            SingleChildScrollView(
              child: Column(
                children: [
                  GradientButton(
                    imagePath: '',
                    title: 'Title',
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                  ),
                  Submission(),
                  GradientButton(
                    imagePath: '',
                    title: 'Title',
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                  ),
                  Submission(),
                  GradientButton(
                    imagePath: '',
                    title: 'Title',
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                  ),
                  Submission(),
                  GradientButton(
                    imagePath: '',
                    title: 'Title',
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                  ),
                  Submission(),
                  GradientButton(
                    imagePath: '',
                    title: 'Title',
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                  ),
                  Submission(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
