import 'package:artisian/view/anotheraccount.dart';
import 'package:flutter/material.dart';
import 'package:artisian/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User loggedinuser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat';
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
    named = {}; // Initialize the named map
    streammessage();
    newuser();
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
        title: Text("World Chats",
            style: TextStyle(
                color: theme.focusColor,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Heading')),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
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
                  return Center(
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
                        horizontal: size.width * 0.020 //10
                        ,
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
                            vertical: 10.0, horizontal: 20.0),
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
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messagebubble extends StatelessWidget {
  messagebubble({
    required this.messaged,
    required this.name,
    required this.isme,
    required this.email,
  });
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
                showBottomSheet(context, email);
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
                    topLeft: Radius.circular(0.0),
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

void showBottomSheet(BuildContext context, String email) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.man_rounded),
              title: Text('Visit Account'),
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
              leading: Icon(Icons.warning_rounded),
              title: Text('Report user'),
              onTap: () {
                FirebaseFirestore.instance
                    .collection('report')
                    .doc('${email}')
                    .set({
                  'email': email,
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
