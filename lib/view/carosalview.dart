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
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("Home",
                      style: TextStyle(color: theme.focusColor, fontSize: 20)),
                ),
              ],
            ),
            AutoRotatingCarousel(widgetList: widgetList, photoUrls: photoUrls),
            SizedBox(
              height: size.height * 0.48, //387
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
                                    builder: (context) =>
                                        Syllabus(level: 'Beginner')));
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
                                      )));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
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
