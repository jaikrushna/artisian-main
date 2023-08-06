import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artisian/viewmodel/course_view_model.dart';
import 'package:provider/provider.dart';

import '../viewmodel/registration_view_model.dart';

class TickButton extends StatefulWidget {
  TickButton({
    required this.isTicked,
    required this.userEmail,
    required this.field,
    required this.level,
    required this.mapname,
  });
  late bool? isTicked;
  late String? userEmail;
  late String field;
  late String? level;
  late String mapname;
  @override
  State<TickButton> createState() => _TickButtonState();
}

class _TickButtonState extends State<TickButton> {
  late final _firestone = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CourseViewModel courseModel = Provider.of<CourseViewModel>(context);
    UserViewModel userModel = Provider.of<UserViewModel>(context);
    return IconButton(
      onPressed: () {
        setState(() {
          if (widget.isTicked == false)
            widget.isTicked = true;
          else if (widget.isTicked == true) widget.isTicked = false;
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
        size: 24.0,
      ),
    );
  }
}
