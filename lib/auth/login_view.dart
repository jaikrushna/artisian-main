import 'package:artisian/helper/custom_text_field.dart';
import 'package:artisian/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
// import '../../Login_Viewmethods/firebase_auth_constants.dart';
// import '../../Login_Viewmethods/google_sginin.dart';
// import '../../widgets/button_widgets.dart';
// import '../../widgets/custom_appbar.dart';

class Login_View extends StatefulWidget {
  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends State<Login_View> {
  //final _firebase = FirebaseFirestore.instance;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isSigningIn = false;
  bool? isChecked = false;
  bool _isLoading = false;
  //final db = FirebaseFirestore.instance;
  String? _password;

  Future<String> sendData(Map<String, dynamic> data) async {
    //await _firebase.collection("users").add(data);
    return "Sucess";
  }

  @override
  /* void initState() {
    
    success_message();
  } */

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      height: 300,
                      child: Image.asset(
                        "assets/icons/logo (2).png",
                        height: 300,
                      ),
                    ),
                  ],
                ),
                Form(
                    child: Column(
                  children: [
                    Container(
                      height: 66,
                      width: 380,
                      child: TextField(
                        controller: email,
                        decoration:
                            ThemeHelper().textInputDecoration('Email', ''),
                        style: TextStyle(fontSize: 17),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 24.0),
                    Container(
                      height: 66,
                      width: 380,
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: ThemeHelper().textInputDecoration(
                            'Password', 'Enter your password'),
                        style: TextStyle(fontSize: 17),
                      ),
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                    ),
                    SizedBox(height: 17.0),
                    CheckboxListTile(
                      selectedTileColor: Color(0XFF7F3DFF),
                      title: Text.rich(
                        TextSpan(
                          text: '',
                          style: TextStyle(fontSize: 14),
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
                      height: 27,
                    ),
                    Column(
                      children: [
                        Container(
                          child: custom_button(
                            width: 200,
                            title: "Continue"
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17,
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
                      height: 17,
                    ),
                    Column(children: [
                      Container(
                        width: 343,
                        child: ElevatedButton(
                          onPressed: () async {
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 195, 195, 196))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/google icon.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Sign Up with Google",
                                style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
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
                                  fontSize: 14),
                            ),
                            TextSpan(
                              text: 'Login',
                              /* recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  /* Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage())) */;
                                }, */
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
