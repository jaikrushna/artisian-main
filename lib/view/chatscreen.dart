// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, empty_catches, must_be_immutable, non_constant_identifier_names, camel_case_types

import 'package:artisian/view/anotheraccount.dart';
import 'package:flutter/material.dart';
import 'package:artisian/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User loggedinuser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat';

  const ChatScreen({Key? key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var messagetext;
  final messagecontroll = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestone = FirebaseFirestore.instance;

  late String idi;
  late Map<String, String> named;
  @override
  void initState() {
    super.initState();
    named = {};
    // Initialize the named map
    fetchUserNames();
    streammessage();
    newuser();
  }

  void fetchUserNames() async {
    final usersSnapshot = await _firestone.collection('users').get();
    named.clear();
    for (var userSnapshot in usersSnapshot.docs) {
      named[userSnapshot['email']] = userSnapshot['name'];
    }
  }

  void newuser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        idi = user.uid;
        loggedinuser = user;
      }
    } catch (e) {}
  }

  void streammessage() async {
    final user = _auth.currentUser;
    if (user != null) {
      idi = user.uid;
      loggedinuser = user;
    }
    await for (var message in _firestone.collection('message').snapshots()) {
      for (var messa in message.docs) {
        messa.data();
      }
    }
    setState(() {});
    // Listen to changes in the 'users' collection to populate the 'named' map
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.disabledColor,
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
        title: Text("Global Chats",
            style: TextStyle(
                color: theme.focusColor,
                fontSize: size.height * 0.047,
                fontWeight: FontWeight.bold,
                fontFamily: 'Title')),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _firestone
                .collection('message')
                .orderBy('messagetime')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              _firestone.collection('users').snapshots().listen((event) {
                // named.clear(); // Clear the map before updating
                event.docs.forEach((element) {
                  named[element['email']] = element['name'];
                });
              });
              final messages = snapshot.data!.docs.reversed;
              List<Widget> Messagelist = [];
              for (var message in messages) {
                final messaged = message.get('text');
                final email = message.get('email');
                final name = named[email];
                final mmail = message.get('id');
                final messagewidget = messagebubble(
                  messaged: messaged,
                  name: name,
                  isme: mmail == idi,
                  email: email,
                );
                Messagelist.add(messagewidget);
              }
              return Expanded(
                child: ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.020,
                      vertical: size.height * 0.025), //20
                  children: Messagelist,
                ),
              );
            },
          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messagecontroll,
                    onChanged: (value) {
                      messagetext = value;
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: theme.focusColor,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size.height * 0.013,
                          horizontal: size.width * 0.040),
                      hintText: 'Type your message here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    messagecontroll.clear();
                    _firestone.collection('message').add({
                      'text': messagetext,
                      'email': loggedinuser.email,
                      'id': idi,
                      'messagetime': Timestamp.now(),
                    });
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: theme.focusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.023,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class messagebubble extends StatelessWidget {
  messagebubble({
    Key? key,
    required this.messaged,
    required this.name,
    required this.isme,
    required this.email,
  }) : super(key: key);
  var messaged;
  String? name;
  bool isme;
  String email;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.007), //10
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          TextButton(
              child: Text(
                '$name',
                style: TextStyle(
                  color: theme.focusColor,
                  fontSize: size.width * 0.033, //12
                ),
                textAlign: TextAlign.left,
              ),
              onPressed: () {
                showBottomSheet(
                  context,
                  email,
                  loggedinuser.email,
                );
              }),
          Material(
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(size.width * 0.070),
                    topRight: Radius.circular(size.width * 0.00),
                    bottomLeft: Radius.circular(size.width * 0.070),
                    bottomRight: Radius.circular(size.width * 0.070),
                  )
                : BorderRadius.only(
                    topLeft: const Radius.circular(0.0),
                    topRight: Radius.circular(size.width * 0.070),
                    bottomLeft: Radius.circular(size.width * 0.070),
                    bottomRight: Radius.circular(size.width * 0.070),
                  ),
            color: isme ? theme.secondaryHeaderColor : theme.backgroundColor,
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.015,
                  horizontal: size.width * 0.050),
              child: Text(
                '$messaged',
                style: TextStyle(
                  color: theme.focusColor,
                  fontSize: size.width * 0.032,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showBottomSheet(BuildContext context, String email, String? reporter) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.man_rounded),
            title: const Text('Visit Account'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Account_View(
                            email: email,
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.warning_rounded),
            title: const Text('Report user'),
            onTap: () {
              FirebaseFirestore.instance
                  .collection('report')
                  .doc('$reporter')
                  .set({
                'email': email,
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
