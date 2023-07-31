import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  ProfilePic({required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill,
          height: 150,
          width: 100,
        ),
      ),
    );
  }
}
