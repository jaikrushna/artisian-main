import 'package:artisian/model/completion.dart';
import 'package:artisian/model/customtile.dart';
import 'package:artisian/model/submission.dart';
import 'package:flutter/material.dart';
import 'package:artisian/view/youtube.dart';
import 'package:artisian/model/course.dart';
import 'package:artisian/viewmodel/course_view_model.dart';
import 'package:provider/provider.dart';
class Syllabus extends StatefulWidget {
  static const route = '/syllabus';
  late String level;
  Syllabus({required this.level});

  @override
  State<Syllabus> createState() => _SyllabusState();
}

class _SyllabusState extends State<Syllabus> {
  @override
  Widget build(BuildContext context) {
    Course? customModel = Provider.of<CourseViewModel>(context).customModel;
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
                  CustomTile(
                    title: 'Title',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                    field: 'vid1',
                    isTicked: customModel!.vid1,
                    level: widget.level,
                  ),
                  Submission(
                    field: 'sub1',
                    isTicked: customModel!.sub1,
                    level: widget.level,
                  ),
                  CustomTile(
                    title: 'Title',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                    field: 'vid2',
                    isTicked: customModel!.vid2,
                    level: widget.level,
                  ),
                  Submission(
                    field: 'sub2',
                    isTicked: customModel!.sub2,
                    level: widget.level,
                  ),
                  CustomTile(
                    title: 'Title',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                    field: 'vid3',
                    isTicked: customModel!.vid3,
                    level: widget.level,
                  ),
                  Submission(
                    field: 'sub3',
                    isTicked: customModel!.sub3,
                    level: widget.level,
                  ),
                  CustomTile(
                    title: 'Title',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                    field: 'vid4',
                    isTicked: customModel!.vid4,
                    level: widget.level,
                  ),
                  Submission(
                    field: 'sub4',
                    isTicked: customModel!.sub4,
                    level: widget.level,
                  ),
                  CustomTile(
                    title: 'Title',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Youtube_screen()));
                    },
                    subtitle: '',
                    field: 'vid5',
                    isTicked: customModel!.vid5,
                    level: widget.level,
                  ),
                  Submission(
                    field: 'sub5',
                    isTicked: customModel!.sub5,
                    level: widget.level,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
