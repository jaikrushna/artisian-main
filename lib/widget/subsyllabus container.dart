import 'package:flutter/material.dart';
import 'package:artisian/view/youtube.dart';

class BulletTextButtonsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blueAccent.withOpacity(0.0), // 50% transparent blue
            Colors.blueAccent.withOpacity(0.0), // 50% transparent green
          ],
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BulletTextButton(text: 'Button 1'),
          BulletTextButton(text: 'Button 2'),
          BulletTextButton(text: 'Button 3'),
          BulletTextButton(text: 'Button 4'),
          BulletTextButton(text: 'Button 5'),
        ],
      ),
    );
  }
}

class BulletTextButton extends StatelessWidget {
  final String text;

  BulletTextButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Youtube_screen()),
        );
      },
      child: SizedBox(
        height: 20, // Set the desired height here
        child: Row(
          children: [
            Text(
              '1.1',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ), // Unicode bullet character
            SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
