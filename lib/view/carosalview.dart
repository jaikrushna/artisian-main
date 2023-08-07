import 'package:artisian/widget/gridtile.dart';
import 'package:artisian/view/syllabus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:artisian/widget/carousal.dart';
import 'package:google_fonts/google_fonts.dart';

class Carosalview extends StatefulWidget {
  @override
  State<Carosalview> createState() => _CarosalviewState();
}

class _CarosalviewState extends State<Carosalview> {
  final List<String> photoUrls = [
    'assets/carousel1.png',
    'assets/carousel2.png',
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
    
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff141414),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 190,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: photoUrls.length,
                  controller: PageController(
                      viewportFraction: 0.94), // Adjust the viewportFraction
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: widgetList[index],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 387,
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
    );
  }
}
