import '../auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class custom_button extends StatelessWidget {
  final double? width;
  String title;
  //final Function onpressed;
  custom_button({
    required this.title,
    required this.width,
    //required this.onpressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  ); */
          Get.to(Login_View());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            Icon(Icons.arrow_forward_ios_sharp, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
