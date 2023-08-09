import 'package:artisian/model/user.dart';
import 'package:artisian/view/updateprofile.dart';
import 'package:artisian/viewmodel/post_view_model.dart';
import 'package:artisian/viewmodel/registration_view_model.dart';
import 'package:artisian/widget/posttile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  final String? email; // Add the email parameter to the constructor
  const Account({Key? key, required this.email}) : super(key: key);
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late final String? email; // Define a variable to store the email
  late CollectionReference _reference; // Move the reference to the state class
  late Stream<QuerySnapshot> _stream;
  late String url;

  List<Widget> memberlist = []; // Renamed from Memberlist to memberlist

  void addData(String url, String id) {
    memberlist.add(PostTile(
      url: url,
      email: email,
      id: id,
    ));
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
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;
    UserViewModel viewModel = Provider.of<UserViewModel>(context);
    return Container(
      color: theme.disabledColor,
      child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(size.height * 0.031), //25
              child: StreamBuilder<Users?>(
                  stream: viewModel.getCurrentUserData(email),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          'Error fetching user data: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    Users? user = snapshot.data;
                    if (user == null) {
                      return const Text('User data not found.');
                    }
                    return Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  size.width * 0.030), //12
                              child: Image.network(
                                user.imageUrl,
                                width: size.width * 0.39, //30
                                height: size.height * 0.210,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: size.height * 0.024,
                            ),
                            Card(
                              elevation:
                                  0.0, // Add some elevation for a material shadow effect
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(size.width *
                                    0.040), // Adjust the radius as needed
                              ),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    size.height * 0.031,
                                    size.height * 0.031,
                                    size.height * 0.0,
                                    size.height * 0.025),
                                width: size.width * 0.39, //30
                                height: size.height * 0.210,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            user.name,
                                            style: TextStyle(
                                              fontSize: size.height * 0.0194,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        widget.email == userEmail
                                            ? IconButton(
                                                iconSize: size.height * 0.019,
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpdateScreen(
                                                                  email: widget
                                                                      .email
                                                                      .toString())));
                                                },
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: size.height * 0.010,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'age: ',
                                            style: TextStyle(
                                              fontSize: size.height * 0.015,
                                            ),
                                          ),
                                          Text(
                                            '${user.age}',
                                            style: TextStyle(
                                              fontSize: size.height * 0.016,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: size.height * 0.010,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'hobby: ',
                                            style: TextStyle(
                                              fontSize: size.height * 0.015,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              user.hobby,
                                              style: TextStyle(
                                                fontSize: size.height * 0.016,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: size.height * 0.010,
                                      ),
                                      child: Text(
                                        '" ${user.bio}"',
                                        style: TextStyle(
                                          fontSize: size.height * 0.015,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffCEA2FD),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Circular container for the GIF
                            ClipOval(
                              child: Container(
                                  width: size.width * 0.420, //30
                                  height: size.height * 0.210,
                                  color: Colors.grey[300],
                                  child: Image.asset(
                                    'assets/icons/fire.gif',
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            // Text widget positioned at the center of the container
                            Positioned(
                              top: size.height * 0.018, //14
                              child: Column(
                                children: [
                                  Text(
                                    'Streak',
                                    style: TextStyle(
                                        fontSize: size.height * 0.012,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    user.streak.toString(),
                                    style: TextStyle(
                                        fontSize: size.height * 0.040,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.035,
                        ),
                        Text(
                          'Post',
                          style: TextStyle(
                              fontSize: size.height * 0.023, //20
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor),
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
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                // If an error occurs, display an error message.
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final tiles = snapshot.data!.docs;
                                memberlist
                                    .clear(); // Clear the previous data before adding new data
                                for (var tile in tiles) {
                                  final documentId = tile.id;
                                  url = tile.get('imageUrl') ?? '';
                                  if (url != '') {
                                    addData(url, documentId);
                                  }
                                }

                                if (url != '') {
                                  return Column(
                                    children: [
                                      GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                1, // Number of columns in the grid
                                            crossAxisSpacing: size.height *
                                                0.010, // Spacing between columns
                                            mainAxisSpacing: size.height *
                                                0.010, // Spacing between rows
                                          ),
                                          itemCount: memberlist.length,
                                          itemBuilder: (context, i) =>
                                              memberlist[i]),
                                    ],
                                  );
                                } else {
                                  // If data is null (no post available), display a message.
                                  return Image.asset('assets/icons/nopost.png');
                                }
                              }
                            }),
                      ],
                    );
                  }))),
    );
  }
}
