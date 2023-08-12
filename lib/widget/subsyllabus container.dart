// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:artisian/view/youtube.dart';

class BulletTextButtonsContainer extends StatelessWidget {
  BulletTextButtonsContainer({
    Key? key,
    required this.index,
    required this.L,
    required this.links,
  }) : super(key: key);
  int index;
  List<String> L;
  List<String> links;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blueAccent.withOpacity(0.0), // 50% transparent blue
            Colors.blueAccent.withOpacity(0.0), // 50% transparent green
          ],
        ),
        borderRadius: BorderRadius.circular(size.width * 0.03),
      ),
      padding: EdgeInsets.all(size.width * 0.055),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BulletTextButton(
            text: L[0],
            course: 0,
            index: index,
            link: links,
          ),
          BulletTextButton(
            text: L[1],
            course: 1,
            index: index,
            link: links,
          ),
          BulletTextButton(
            text: L[2],
            course: 2,
            index: index,
            link: links,
          ),
          BulletTextButton(
            text: L[3],
            course: 3,
            index: index,
            link: links,
          ),
          BulletTextButton(
            text: L[4],
            course: 4,
            index: index,
            link: links,
          ),
        ],
      ),
    );
  }
}

class BulletTextButton extends StatelessWidget {
  final String text;
  final int course;
  final int index;
  final List<String> link;
  const BulletTextButton(
      {Key? key,
      required this.text,
      required this.course,
      required this.index,
      required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Youtube_screen(
                    link: link[course],
                  )),
        );
      },
      child: SizedBox(
        height: size.height * 0.06, // Set the desired height here
        child: Row(
          children: [
            Text(
              '${index + 1}.${course + 1}',
              style: TextStyle(
                fontSize: size.height * 0.018,
                color: Colors.white,
              ),
            ), // Unicode bullet character
            SizedBox(width: size.width * 0.017),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: size.height * 0.018,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
