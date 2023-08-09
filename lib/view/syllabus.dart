import 'package:artisian/widget/completion.dart';
import 'package:artisian/widget/customtile.dart';
import 'package:artisian/widget/submission.dart';
import 'package:flutter/material.dart';
import 'package:artisian/model/course.dart';
import 'package:artisian/viewmodel/course_view_model.dart';

// ignore: must_be_immutable
class Syllabus extends StatefulWidget {
  static const route = '/syllabus';
  late String level;
  Syllabus({Key? key, required this.level}) : super(key: key);

  @override
  State<Syllabus> createState() => _SyllabusState();
}

class _SyllabusState extends State<Syllabus> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.backgroundColor,
        ),
        body: Container(
          color: theme.disabledColor,
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.011), //8
            child: FutureBuilder<Course?>(
                future: CourseViewModel().getCurrentCourseData(widget.level),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final course = snapshot.data;
                    if (course != null) {
                      return ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(size.height * 0.020), //8
                        children: [
                          Completion(
                            level: widget.level,
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                CustomTile(
                                  index: 0,
                                  field: 'vid1',
                                  isTicked: course.vid['vid1'],
                                  level: widget.level,
                                ),
                                Submission(
                                  field: 'sub1',
                                  isTicked: course.sub['sub1'],
                                  level: widget.level,
                                ),
                                CustomTile(
                                  index: 1,
                                  field: 'vid2',
                                  isTicked: course.vid['vid2'],
                                  level: widget.level,
                                ),
                                Submission(
                                  field: 'sub2',
                                  isTicked: course.sub['sub2'],
                                  level: widget.level,
                                ),
                                CustomTile(
                                  index: 2,
                                  field: 'vid3',
                                  isTicked: course.vid['vid3'],
                                  level: widget.level,
                                ),
                                Submission(
                                  field: 'sub3',
                                  isTicked: course.sub['sub3'],
                                  level: widget.level,
                                ),
                                CustomTile(
                                  index: 3,
                                  field: 'vid4',
                                  isTicked: course.vid['vid4'],
                                  level: widget.level,
                                ),
                                Submission(
                                  field: 'sub4',
                                  isTicked: course.sub['sub4'],
                                  level: widget.level,
                                ),
                                CustomTile(
                                  index: 4,
                                  field: 'vid5',
                                  isTicked: course.vid['vid5'],
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
                      return Text(
                          'No course data available for $widget.level.');
                    }
                  }
                }),
          ),
        ));
  }
}
