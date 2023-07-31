import 'package:artisian/provider/TickButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:provider/provider.dart';

class CustomTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  late bool? isTicked;
  late String field;
  late String? level;
  CustomTile({
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.isTicked,
    required this.field,
    required this.level,
  });

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    String? userEmail = Provider.of<EmailViewModel>(context).userEmail;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  TickButton(
                    isTicked: widget.isTicked,
                    userEmail: userEmail,
                    field: widget.field,
                    level: widget.level,
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
