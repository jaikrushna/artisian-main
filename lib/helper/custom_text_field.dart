import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

late Size size;

class ThemeHelper {
  InputDecoration textInputDecoration(
      [String lableText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: lableText,
      labelStyle: TextStyle(
        color: Color(0xff951B80),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      filled: true,
      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.0),
          borderSide: BorderSide(color: Color(0xff951B80), width: 2.5)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.0),
          borderSide: BorderSide(color: Color(0xff951B80), width: 1.0)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0),
        blurRadius: 20,
        offset: const Offset(0, 5),
      ),
    ]);
  }

  BoxDecoration buttonBoxDecoration(BuildContext context,
      [String color1 = "", String color2 = ""]) {
    Color c1 = Theme.of(context).primaryColor;
    // Color c2 = Theme.of(context).accentColor;
    if (color1.isEmpty == false) {
      c1 = HexColor(color1);
    }
    if (color2.isEmpty == false) {
      // c2 = HexColor(color2);
    }

    return BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Color(0XFF91919F), offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
