import 'package:artisian/model/user.dart';
import 'package:artisian/view/updateprofile.dart';
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
  late final String? email;
  late CollectionReference _reference;
  late Stream<QuerySnapshot> _stream;
  late String url;

  List<Widget> memberlist = [];

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

    email = widget.email;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.disabledColor,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: theme.focusColor,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        automaticallyImplyLeading: false,
        title: Text("Profile",
            style: TextStyle(
                color: theme.focusColor,
                fontSize: size.height * 0.047,
                fontWeight: FontWeight.bold,
                fontFamily: 'Title')),
        centerTitle: true,
      ),
      body: Container(
        color: theme.disabledColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.031),
            child: StreamBuilder<Users?>(
              stream: viewModel.getCurrentUserData(email),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error fetching user data: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                Users? user = snapshot.data;

                if (user == null) {
                  return const Text('User data not found.');
                }

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(size.width * 0.030),
                      child: user.imageUrl == ""
                          ? Image.asset("assets/icons/logo.png",
                              width: size.width * 0.39,
                              height: size.height * 0.210)
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                FadeInImage.assetNetwork(
                                  placeholder: "assets/icons/logo.png",
                                  image: user.imageUrl,
                                  width: size.width * 0.39,
                                  height: size.height * 0.210,
                                  fit: BoxFit.cover,
                                  placeholderScale: 0.5,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/icons/logo.png",
                                      height: size.height * 0.210,
                                      width: size.width * 0.39,
                                    );
                                  },
                                ),
                                Visibility(
                                  visible: user.imageUrl.isEmpty,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),

                    // Profile Image and Name Card
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xff331241).withOpacity(0.10),
                              const Color(0xFFFCE4EC).withOpacity(0.40)
                            ], // Add your desired gradient colors here
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(size.height * 0.025),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start, // Adjust alignment
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        Text(
                                            user.name
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: theme.focusColor,
                                                fontSize: size.height * 0.024,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Name')),
                                        Text(
                                            user.name
                                                .substring(1)
                                                .toLowerCase(),
                                            style: TextStyle(
                                                color: theme.focusColor,
                                                fontSize: size.height * 0.024,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Name')),
                                      ],
                                    ),
                                  ),
                                  if (widget.email == userEmail)
                                    IconButton(
                                      iconSize: size.height * 0.019,
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateScreen(
                                              email: widget.email.toString(),
                                              user: user,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.015),
                              Row(
                                children: [
                                  Text(
                                    'Age: ',
                                    style: TextStyle(
                                      fontSize: size.height * 0.019,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${user.age}',
                                    style: TextStyle(
                                      fontSize: size.height * 0.019,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.010),
                              Row(
                                children: [
                                  Text(
                                    'Hobby: ',
                                    style: TextStyle(
                                      fontSize: size.height * 0.019,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    // Allow hobby text to wrap
                                    child: Text(
                                      user.hobby,
                                      style: TextStyle(
                                        fontSize: size.height * 0.019,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.010),
                              Row(
                                children: [
                                  Expanded(
                                    // Allow bio text to wrap
                                    child: Text(
                                      '" ${user.bio}"',
                                      style: TextStyle(
                                        fontSize: size.height * 0.030,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xffCEA2FD),
                                        fontFamily: 'Heading',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.025),

                    // ... Rest of the code ...
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
                    StreamBuilder<QuerySnapshot>(
                        stream: _stream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While waiting for data, you can display a loading indicator.
                            return const Center(
                                child: CircularProgressIndicator());
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
