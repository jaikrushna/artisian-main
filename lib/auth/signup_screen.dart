import 'package:artisian/auth/login_screen.dart';
import 'package:artisian/helper/custom_text_field.dart';
import 'package:artisian/widget/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artisian/auth/register_view.dart';

class Login_View extends StatefulWidget {
  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends State<Login_View> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool progress = false;
  bool? isChecked = false;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.022), //16.0
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.015, //10
                ),
                Column(
                  children: [
                    Container(
                      height: size.height * 0.35, //300
                      child: Image.asset(
                        "assets/icons/logo (2).png",
                        height: size.height * 0.35,
                      ),
                    ),
                  ],
                ),
                Form(
                    child: Column(
                  children: [
                    Container(
                      height: size.height * 0.078, //66
                      width: size.width * 0.90, //380
                      child: TextField(
                        controller: email,
                        decoration:
                            ThemeHelper().textInputDecoration('Email', ''),
                        style: TextStyle(fontSize: size.width * 0.042), //17
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: size.height * 0.030), //24
                    Container(
                      height: size.height * 0.078, //66
                      width: size.width * 0.90,
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: ThemeHelper().textInputDecoration(
                            'Password', 'Enter your password'),
                        style: TextStyle(fontSize: size.width * 0.042),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: size.height * 0.022), //17
                    CheckboxListTile(
                      selectedTileColor: Color(0XFF7F3DFF),
                      title: Text.rich(
                        TextSpan(
                          text: '',
                          style: TextStyle(fontSize: size.width * 0.036), //14
                          children: [
                            TextSpan(
                              text: 'By signing up, you agree to the ',
                            ),
                            TextSpan(
                              text: 'Terms of Service and Privacy Policy',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                      ),
                      value: isChecked,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                      //secondary: const Icon(Icons.hourglass_empty),
                    ),
                    SizedBox(
                      height: size.height * 0.038, //27
                    ),
                    Column(
                      children: [
                        Container(
                            height: 50,
                            width: size.width * 0.55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistrationScreen(
                                            email: email.text,
                                            passkey: password.text,
                                          )),
                                );
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
                                    "Continue",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Icon(Icons.arrow_forward_ios_sharp,
                                      color: Colors.black),
                                ],
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.024, //17
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Or with",
                          style: TextStyle(
                            color: Color(0XFF91919F),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.024, //17
                    ),
                    Column(children: [
                      Container(
                        width: size.width * 0.84, //343
                        child: ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.022),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 195, 195, 196))),
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.16, //20
                                vertical: size.height * 0.022 //16
                                ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/google icon.png'),
                              SizedBox(
                                height: size.height * 0.015, //10
                              ),
                              Text(
                                "Sign Up with Google",
                                style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.036), //14
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: GoogleFonts.inter(
                                  color: Color(0XFF91919F),
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width * 0.036),
                            ),
                            TextSpan(
                              text: 'Login',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Login_Screen()));
                                },
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
