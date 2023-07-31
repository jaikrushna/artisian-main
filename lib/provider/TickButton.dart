import 'package:artisian/provider/incre_decre.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TickButton extends StatefulWidget {
  TickButton({
    required this.isTicked,
    required this.userEmail,
    required this.field,
    required this.level,
  });
  late bool? isTicked;
  late String? userEmail;
  late String field;
  late String? level;
  @override
  State<TickButton> createState() => _TickButtonState();
}

class _TickButtonState extends State<TickButton> {
  late final _firestone = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (widget.isTicked == false)
          widget.isTicked = true;
        else if (widget.isTicked == true) widget.isTicked = false;

        setState(() {
          _firestone
              .collection('course')
              .doc('${widget.userEmail}')
              .collection('${widget.userEmail}')
              .doc('${widget.level}')
              .set({
            '${widget.field}': widget.isTicked,
          });
          if (widget.isTicked == true)
            incrementField(widget.userEmail);
          else if (widget.isTicked == false) decrementField(widget.userEmail);
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
