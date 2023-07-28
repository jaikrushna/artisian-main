import 'package:flutter/material.dart';

class MyGridTile extends StatelessWidget {
  // final String imagePath;
  final String title;
  final VoidCallback onPressed;

  MyGridTile({
    // required this.imagePath,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.green], // You can add more colors here
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180,
                  // child:
                  // Image.network(
                  //   // imagePath,
                  //   width: 100,
                  //   height: 100,
                  // ),
                ),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
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
