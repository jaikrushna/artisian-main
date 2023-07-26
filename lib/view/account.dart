import 'package:artisian/model/completion.dart';
import 'package:artisian/provider/posttile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('post').doc('jb').collection('jb');
  late Stream<QuerySnapshot> _stream = _reference.orderBy('date').snapshots();
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
                SizedBox(
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
                    padding: EdgeInsets.all(16.0),
                    width: 159,
                    height: 170,
                    child: Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
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
                            padding: const EdgeInsets.only(bottom: 8.0),
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
                            padding: const EdgeInsets.only(bottom: 8.0),
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
                            padding: const EdgeInsets.only(bottom: 8.0),
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
            SizedBox(
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
                Positioned(
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
            SizedBox(
              height: 15,
            ),
            Completion(),
            SizedBox(
              height: 15,
            ),
            Text(
              'Post',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Divider(
              color: Colors.black,
            ),

            // StreamBuilder to display the list of posts
            StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Image.asset('assets/icons/nopost.png'));
                }

                final tiles = snapshot.data!.docs;
                memberlist
                    .clear(); // Clear the previous data before adding new data
                for (var tile in tiles) {
                  url = tile.get('imageURL') ?? '';
                  addData(url);
                }

                return Column(
                  children: [
                    GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // Number of columns in the grid
                          crossAxisSpacing: 8.0, // Spacing between columns
                          mainAxisSpacing: 8.0, // Spacing between rows
                        ),
                        itemCount: memberlist.length,
                        itemBuilder: (context, i) => memberlist[i]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
