import 'package:artisian/model/completion.dart';
import 'package:artisian/model/customtile.dart';
import 'package:artisian/model/submission.dart';
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      customModel.fetchDocumentData(userEmail, widget.level);
    });
    // final model = customModel.fetchDocumentData(userEmail, widget.level);
    // customModel?.fetchDocumentData(userEmail, widget.level);
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<CourseViewModel>(builder: (context, model, child) {
            if (model.customModel == null) {
              return CircularProgressIndicator();
            }
            final user = model.customModel!;
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
                                  builder: (context) => Youtube_screen()));
                        },
                        subtitle: '',
                        field: 'vid1',
                        isTicked: user.vid1,
                        level: widget.level,
                      ),
                      Submission(
                        field: 'sub1',
                        isTicked: user.sub1,
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
                        isTicked: user.vid2,
                        level: widget.level,
                      ),
                      Submission(
                        field: 'sub2',
                        isTicked: user.sub2,
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
                        isTicked: user.vid3,
                        level: widget.level,
                      ),
                      Submission(
                        field: 'sub3',
                        isTicked: user.sub3,
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
                        isTicked: user.vid4,
                        level: widget.level,
                      ),
                      Submission(
                        field: 'sub4',
                        isTicked: user.sub4,
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
                        isTicked: user.vid5,
                        level: widget.level,
                      ),
                      Submission(
                        field: 'sub5',
                        isTicked: user.sub5,
                        level: widget.level,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
