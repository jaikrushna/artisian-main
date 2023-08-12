import 'package:artisian/widget/carousal.dart';
import 'package:artisian/widget/gridtile.dart';
import 'package:artisian/view/syllabus.dart';
import 'package:flutter/material.dart';

class Carosalview extends StatefulWidget {
  const Carosalview({Key? key}) : super(key: key);

  @override
  State<Carosalview> createState() => _CarosalviewState();
}

class _CarosalviewState extends State<Carosalview> {
  final List<String> photoUrls = [
    'assets/carousel1.png',
    'assets/carousel2.png',
    'assets/carousel3.png',
  ];
  List<Widget> widgetList = [
    Image.asset(
      'assets/carousel1.png', // Replace with your image URL
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
    Image.asset(
      'assets/carousel2.png', // Replace with your image URL
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
    Image.asset(
      'assets/carousel3.png', // Replace with your image URL
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: theme.disabledColor,
        child: Column(
          children: [
            Row(
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: theme.focusColor,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 130.0),
                  child: Text("Home",
                      style: TextStyle(
                        color: theme.focusColor,
                        fontSize: size.height * 0.047,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Title',
                      )),
                ),
              ],
            ),
            AutoRotatingCarousel(widgetList: widgetList, photoUrls: photoUrls),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 1, // Height of the horizontal line
                  width: size.width * 0.4, // Width of the horizontal line
                  decoration: BoxDecoration(
                    color: theme.focusColor, // Color of the line
                  ),
                ),
                const Text(
                  '   Stages  ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 1, // Height of the horizontal line
                  width: size.width * 0.4, // Width of the horizontal line
                  decoration: BoxDecoration(
                    color: theme.focusColor, // Color of the line
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            SizedBox(
              height: size.height * 0.43, //387
              child: Column(
                children: [
                  Row(
                    children: [
                      MyGridTile(
                          imagePath: 'assets/icons/stage32.png',
                          title: 'Rookie',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Syllabus(
                                          level: 'Beginner',
                                          title: 'Rookie',
                                        )));
                          }),
                      MyGridTile(
                        imagePath: 'assets/icons/stage22.png',
                        title: 'Master',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Syllabus(
                                        level: 'Intermediate',
                                        title: 'Master',
                                      )));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyGridTile(
                        imagePath: 'assets/icons/stage12.png',
                        title: 'Legend',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Syllabus(
                                        level: 'Advance',
                                        title: 'Legend',
                                      )));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
