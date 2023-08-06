import 'package:artisian/widget/gridtile.dart';
import 'package:artisian/view/syllabus.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:artisian/widget/carousal.dart';

// Widget buildAdvertismentPlace() {
//   return Padding(
//     padding: EdgeInsets.all(18.0),
//     child: Container(
//       height: 170,
//       child:
//       // Carousel(
//       //   autoplay: true,
//       //   animationCurve: Curves.fastOutSlowIn,
//       //   animationDuration: Duration(microseconds: 1000),
//       //   showIndicator: false,
//       //   images: [
//       //     Container(
//       //       margin: EdgeInsets.only(right: 10),
//       //       decoration: BoxDecoration(
//       //         image: DecorationImage(
//       //           fit: BoxFit.cover,
//       //           image: NetworkImage(
//       //               "https://blog.creatopy.com/wp-content/uploads/2019/03/creative-advertising-and-pop-culture-pop-culture-ads.png"),
//       //         ),
//       //         borderRadius: BorderRadius.circular(10.0),
//       //       ),
//       //     ),
//       //     Container(
//       //       decoration: BoxDecoration(
//       //         image: DecorationImage(
//       //           fit: BoxFit.cover,
//       //           image: NetworkImage(
//       //             "https://blog.creatopy.com/wp-content/uploads/2018/05/advertisement-ideas-inspiration-advertising.png",
//       //           ),
//       //         ),
//       //         borderRadius: BorderRadius.circular(10.0),
//       //       ),
//           ),
//         ],
//   //     ),
//   // //   ),
//   );
// }

class Carosalview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff141414),
      child: Column(
        children: [
          SizedBox(
            // child: buildAdvertismentPlace(),
            height: 260,
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
