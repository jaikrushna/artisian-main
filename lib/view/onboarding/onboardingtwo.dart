import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Image.asset(
        "assets/on2.png",
        fit: BoxFit.fill,
      ),
    );
  }
}
