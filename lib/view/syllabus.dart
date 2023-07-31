import 'package:artisian/widget/completion.dart';
import 'package:artisian/widget/customtile.dart';
import 'package:artisian/widget/submission.dart';
import 'package:artisian/viewmodel/email_view.dart';
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
    String? userEmail = Provider.of<EmailViewModel>(context).userEmail;
    final customModel = Provider.of<CourseViewModel>(context);
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final model = await customModel.getCurrentCourseData(widget.level);
    });
    // final model = customModel.getCurrentCourseData(widget.level);
    // customModel?.fetchDocumentData(userEmail, widget.level);
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<Course?>(
              future: CourseViewModel().getCurrentCourseData(widget.level),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for data, you can display a loading indicator.
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // If an error occurs, display an error message.
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If data is available, you can display it.
                  final course = snapshot.data;
                  if (course != null) {
                    return ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15.0),
                      children: [
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
                                          builder: (context) =>
                                              Youtube_screen()));
                                },
                                subtitle: '',
                                field: 'vid1',
                                isTicked: course.sub['vid1'],
                                level: widget.level,
                              ),
                              Submission(
                                field: 'sub1',
                                isTicked: course.sub['sub1'],
                                level: widget.level,
                              ),
                              CustomTile(
                                title: 'Title',
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Youtube_screen()));
                                },
                                subtitle: '',
                                field: 'vid2',
                                isTicked: course.sub['vid2'],
                                level: widget.level,
                              ),
                              Submission(
                                field: 'sub2',
                                isTicked: course.sub['sub2'],
                                level: widget.level,
                              ),
                              CustomTile(
                                title: 'Title',
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Youtube_screen()));
                                },
                                subtitle: '',
                                field: 'vid3',
                                isTicked: course.sub['vid3'],
                                level: widget.level,
                              ),
                              Submission(
                                field: 'sub3',
                                isTicked: course.sub['sub3'],
                                level: widget.level,
                              ),
                              CustomTile(
                                title: 'Title',
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Youtube_screen()));
                                },
                                subtitle: '',
                                field: 'vid4',
                                isTicked: course.sub['vid4'],
                                level: widget.level,
                              ),
                              Submission(
                                field: 'sub4',
                                isTicked: course.sub['sub4'],
                                level: widget.level,
                              ),
                              CustomTile(
                                title: 'Title',
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Youtube_screen()));
                                },
                                subtitle: '',
                                field: 'vid5',
                                isTicked: course.sub['vid5'],
                                level: widget.level,
                              ),
                              Submission(
                                field: 'sub5',
                                isTicked: course.sub['sub5'],
                                level: widget.level,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    // If data is null (no course available), display a message.
                    return Text('No course data available for $widget.level.');
                  }
                }
              }),
        ));
  }
}
