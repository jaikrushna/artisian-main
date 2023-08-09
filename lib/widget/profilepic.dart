import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  ProfilePic({required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.011),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size.width * 0.055),
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
            height: size.height * 0.22,
            width: size.width * 0.31,
          ),
        ),
      ),
    );
  }
}
