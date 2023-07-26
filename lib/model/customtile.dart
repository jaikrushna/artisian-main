import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onPressed;

  GradientButton({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    child: Image.asset(
                      imagePath,
                      width: 4,
                      height: 40,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        subtitle,
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
