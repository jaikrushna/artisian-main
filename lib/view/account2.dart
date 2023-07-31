import 'package:artisian/widget/completion.dart';
import 'package:artisian/provider/posttile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/post.dart';
import '../viewmodel/post_view_model.dart';

class Account extends StatefulWidget {
  Account({
    required this.email,
  });
  final String email;
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late CollectionReference reference = FirebaseFirestore.instance
      .collection('post')
      .doc(widget.email)
      .collection('${widget.email}');
  late Stream<QuerySnapshot> _stream = reference.orderBy('date').snapshots();
  late String url;
  var _isloading = false;
  late final _firestone = FirebaseFirestore.instance;

  List<Widget> memberlist = []; // Renamed from Memberlist to memberlist

  void addData(String url) {
    memberlist.add(PostTile(url: url));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/artisian-25b23.appspot.com/o/profilepic%2Flion.jpg?alt=media&token=ed5f39ca-532c-4b0c-8856-c370caa26504',
                    width: 155,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Card(
                  elevation:
                      0.0, // Add some elevation for a material shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        16.0), // Adjust the radius as needed
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: 159,
                    height: 170,
                    child: const Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    'JB',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'age: ',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  '23',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'hobby: ',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Sketching',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '\" Enjoy the Journey \"',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                // Circular container for the GIF
                ClipOval(
                  child: Container(
                      width: 180,
                      height: 180,
                      color: Colors.grey[300],
                      child: Image.asset(
                        'assets/icons/fire.gif',
                        fit: BoxFit.fill,
                      )),
                ),
                // Text widget positioned at the center of the container
                const Positioned(
                  top: 14,
                  child: Column(
                    children: [
                      Text(
                        'Streak',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        '8',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Completion(),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Post',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Divider(
              color: Colors.black,
            ),

            // StreamBuilder to display the list of posts
            StreamBuilder<Post?>(
              stream: PostViewModel()
                  .getCurrentPostData(), // Replace 'PostViewModel()' with your actual instance of PostViewModel.
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for data, you can display a loading indicator.
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // If an error occurs, display an error message.
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If data is available, you can display it.
                  final post = snapshot.data;
                  if (post != null) {
                    return Column(
                      children: [
                        Image.network(
                          post.imageUrl,
                          width: 100,
                          height: 100,
                        ),
                      ],
                    );
                  } else {
                    // If data is null (no post available), display a message.
                    return Text('No post data available.');
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
