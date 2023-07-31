import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class App_Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('ShopIT'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          TextButton(
            child: ListTile(
              title: Text("SHOP"),
              trailing: Icon(
                Icons.shop,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          TextButton(
            child: ListTile(
              title: Text("Orders"),
              trailing: Icon(
                Icons.shopping_bag,
              ),
            ),
            onPressed: () {},
          ),
          Divider(),
          TextButton(
            child: ListTile(
              title: Text("User Products"),
              trailing: Icon(
                Icons.edit_rounded,
              ),
            ),
            onPressed: () {},
          ),
          Divider(),
          TextButton(
            child: ListTile(
              title: Text("Log Out"),
              trailing: Icon(
                Icons.logout,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              // Navigator.pushReplacementNamed('/');
              Provider.of(context, listen: false).logout();
              // Navigator.of(context)
              //     .pushReplacementNamed(User_product_screen.routee);
            },
          ),
        ],
      ),
    );
  }
}
