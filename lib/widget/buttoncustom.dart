import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double size;
  final Color innerColor;
  final Color outerColor;
  final VoidCallback onPressed;
  final Key? key; // Make the key property nullable

  CustomButton({
    required this.size,
    required this.innerColor,
    required this.outerColor,
    required this.onPressed,
    this.key, // Provide a default value of null
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        key: key, // Assign the key to the container
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: outerColor,
              ),
            ),
            Container(
              width: size * 0.75,
              height: size * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            Container(
              width: size * 0.7,
              height: size * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: innerColor,
              ),
              child: Icon(
                Icons.arrow_forward_sharp,
                size: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
