import 'package:flutter/material.dart';

class MyGridTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onPressed;

  const MyGridTile({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width * 0.02),
      child: Container(
        height: size.height * 0.18,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xff5D0B5F).withOpacity(0.10), // 50% transparent blue
              Colors.deepPurple.withOpacity(0.7), // 50% transparent green
            ],
          ),
          borderRadius: BorderRadius.circular(size.width * 0.02),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.46,
                  child: Image.asset(
                    imagePath,
                    width: size.width * 0.22,
                    height: size.height * 0.12,
                  ),
                ),
                SizedBox(width: size.width * 0.02),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
