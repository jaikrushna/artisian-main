import 'package:artisian/model/user.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:artisian/widget/completion.dart';
import 'package:artisian/provider/posttile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  final String? email; // Add the email parameter to the constructor
  Account({required this.email});
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late final String? email; // Define a variable to store the email
  late CollectionReference _reference; // Move the reference to the state class
  late Stream<QuerySnapshot> _stream;
  late String url;
  var _isloading = false;

  List<Widget> memberlist = []; // Renamed from Memberlist to memberlist

  void addData(String url) {
    memberlist.add(PostTile(url: url));
  }

  @override
  void initState() {
    super.initState();
    email = widget.email; // Initialize the email variable from the widget
    _reference = FirebaseFirestore.instance
        .collection('post')
        .doc(email)
        .collection(email!);
    _stream = _reference.orderBy('date').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: StreamBuilder<Users?>(
                stream: viewModel.getCurrentUserData(email),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error fetching user data: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  Users? user = snapshot.data;
                  if (user == null) {
                    return Text('User data not found.');
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              user.imageUrl,
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
                              child: Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              user.name,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'age: ',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          Text(
                                            '${user.age}',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'hobby: ',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              user.hobby,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                '\" ${user.bio}\"',
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
                                  user.streak.toString(),
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
                      // Completion(),
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
                      StreamBuilder<QuerySnapshot>(
                          stream: _stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // While waiting for data, you can display a loading indicator.
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // If an error occurs, display an error message.
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final tiles = snapshot.data!.docs;
                              memberlist
                                  .clear(); // Clear the previous data before adding new data
                              for (var tile in tiles) {
                                url = tile.get('imageUrl') ?? '';
                                addData(url);
                              }

                              if (tiles != null && url != '') {
                                return Column(
                                  children: [
                                    GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              1, // Number of columns in the grid
                                          crossAxisSpacing:
                                              8.0, // Spacing between columns
                                          mainAxisSpacing:
                                              8.0, // Spacing between rows
                                        ),
                                        itemCount: memberlist.length,
                                        itemBuilder: (context, i) =>
                                            memberlist[i]),
                                  ],
                                );
                              } else {
                                // If data is null (no post available), display a message.
                                return Container(
                                  child: Image.asset('assets/icons/nopost.png'),
                                );
                              }
                            }
                          }),
                    ],
                  );
                })));
  }
}
