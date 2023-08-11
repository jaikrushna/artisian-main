import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: Image.asset(
        "assets/on1.png",
        fit: BoxFit.fill,
      ),
    );
  }
}
