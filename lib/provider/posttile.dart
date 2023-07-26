import 'package:flutter/material.dart';

class PostTile extends StatefulWidget {
  PostTile({
    required this.url,
  });
  final String url;
  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0, // Add some elevation for a material shadow effect
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16.0), // Adjust the radius as needed
        ),
        child: Image.network(
          '${widget.url}',
          fit: BoxFit.fitHeight,
          width: 200,
          height: 150,
        ));
  }
}
