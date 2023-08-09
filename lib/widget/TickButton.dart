// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:artisian/viewmodel/course_view_model.dart';
import 'package:provider/provider.dart';
import '../viewmodel/registration_view_model.dart';

class TickButton extends StatefulWidget {
  TickButton({
    Key? key,
    required this.isTicked,
    required this.userEmail,
    required this.field,
    required this.level,
    required this.mapname,
  }) : super(key: key);
  late bool? isTicked;
  late String? userEmail;
  late String field;
  late String? level;
  late String mapname;
  @override
  State<TickButton> createState() => _TickButtonState();
}

class _TickButtonState extends State<TickButton> {
  @override
  Widget build(BuildContext context) {
    CourseViewModel courseModel = Provider.of<CourseViewModel>(context);
    UserViewModel userModel = Provider.of<UserViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return IconButton(
      onPressed: () {
        setState(() {
          if (widget.isTicked == false) {
            widget.isTicked = true;
          } else if (widget.isTicked == true) {
            widget.isTicked = false;
          }
          courseModel.updateFieldValue(
            widget.level,
            widget.mapname,
            widget.field,
            widget.isTicked,
          );
          userModel.updateStreakAndDate(widget.isTicked);
        });
      },
      icon: Icon(
        (widget.isTicked == true)
            ? Icons.check_circle
            : Icons.radio_button_unchecked,
        color: (widget.isTicked == true)
            ? Colors.green
            : Colors.grey, // Change the color as needed.
        size: size.width * 0.05,
      ),
    );
  }
}
