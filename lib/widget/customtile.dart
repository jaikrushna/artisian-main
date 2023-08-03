// ignore_for_file: must_be_immutable

import 'package:artisian/provider/TickButton.dart';
import 'package:artisian/view/youtube.dart';
import 'package:flutter/material.dart';
import 'package:artisian/viewmodel/email_view.dart';
import 'package:provider/provider.dart';

class CustomTile extends StatefulWidget {
  final String title;
  final String subtitle;
  late bool? isTicked;
  late String field;
  late String? level;
  CustomTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isTicked,
    required this.field,
    required this.level,
  }) : super(key: key);

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    String? userEmail = Provider.of<EmailViewModel>(context).userEmail;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.011), //8
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
          borderRadius: BorderRadius.circular(size.height * 0.011),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Youtube_screen()));
            },
            child: Padding(
              padding: EdgeInsets.all(size.height * 0.022), //16
              child: Row(
                children: [
                  TickButton(
                    isTicked: widget.isTicked,
                    userEmail: userEmail,
                    field: widget.field,
                    level: widget.level,
                    mapname: 'vid',
                  ),
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.042, //16
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.subtitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.035,
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
