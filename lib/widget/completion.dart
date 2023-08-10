// ignore_for_file: must_be_immutable

import 'package:artisian/viewmodel/course_view_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class Completion extends StatefulWidget {
  Completion({Key? key, required this.level}) : super(key: key);
  late String level;

  @override
  State<Completion> createState() => _CompletionState();
}

class _CompletionState extends State<Completion> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    CourseViewModel viewModel = Provider.of<CourseViewModel>(context);
    return StreamBuilder<int?>(
        stream: viewModel.getCourseValue(widget.level),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            int? course = snapshot.data;
            if (course != null) {
              course = course * 10;
              return Card(
                color: theme.primaryColor,
                elevation: size.height * 0.07, //5
                shadowColor: Colors.grey,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.height * 0.020),
                      child: CircularPercentIndicator(
                        animation: true,
                        animationDuration: 2000,
                        radius: size.height * 0.075, //60
                        lineWidth: size.height * 0.010,
                        percent: course / 100,
                        progressColor: theme.backgroundColor,
                        backgroundColor: Colors.blueGrey,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          '$course%',
                          style: TextStyle(
                            fontSize: size.width * 0.054,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '$course% Completed',
                          style: TextStyle(
                            fontSize: size.width * 0.042, //17
                            color: theme.backgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.007, //7
                        ),
                        Text(
                          course == 100 ? 'Yeh Buddy!' : 'Try Your Best !',
                          style: TextStyle(
                            fontSize: size.width * 0.058, //22
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            } else {
              // If data is null (no course available), display a message.
              return Text('No course data available for $widget.level.');
            }
          }
        });
  }
}
