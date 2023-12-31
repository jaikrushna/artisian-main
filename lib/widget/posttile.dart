// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:artisian/viewmodel/post_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostTile extends StatefulWidget {
  const PostTile({
    Key? key,
    required this.id,
    required this.url,
    required this.email,
  }) : super(key: key);
  final String url;
  final String id;
  final String? email;
  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PostViewModel viewModel = Provider.of<PostViewModel>(context);
    String? userEmail = user?.email;
    void _showDeleteConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete Post'),
            content: const Text('Are you sure you want to delete the post?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  viewModel.deletePost(userEmail.toString(), widget.id);
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
    }

    return Card(
        elevation: 4.0, // Add some elevation for a material shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              size.width * 0.06), // Adjust the radius as needed
        ),
        child: Column(
          children: [
            Image.network(
              widget.url,
              fit: BoxFit.fitHeight,
              width: size.width * 0.99,
              height: size.height * 0.35,
            ),
            widget.email == userEmail
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            _showDeleteConfirmationDialog();
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  )
                : const SizedBox(),
          ],
        ));
  }
}
