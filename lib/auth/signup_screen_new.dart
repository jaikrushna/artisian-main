import 'package:artisian/auth/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:artisian/auth/login_screen.dart';
import 'package:artisian/helper/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isChecked = false;
  bool obscure3 = true;
  void showpass3() {
    setState(() {
      obscure3 = !obscure3;
    });
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.disabledColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size.height * 0.022),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.015),
              SizedBox(
                height: size.height * 0.35,
                child: Image.asset(
                  "assets/icons/logo (2).png",
                  height: size.height * 0.35,
                ),
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.078,
                      width: size.width * 0.90,
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextField(
                        controller: email,
                        decoration:
                            ThemeHelper().textInputDecoration('Email', ''),
                        style: TextStyle(
                            fontSize: size.width * 0.042, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: size.height * 0.030),
                    Container(
                      height: size.height * 0.078, //66
                      width: size.width * 0.90,
                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                      child: TextFormField(
                        controller: password,
                        obscureText: obscure3,

                        decoration: InputDecoration(
                          labelText: 'Password..',
                          labelStyle: const TextStyle(
                            color: Color(0xff951B80),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.height * 0.025,
                              horizontal: size.width * 0.06),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: const BorderSide(
                                  color: Color(0xff951B80), width: 2.5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                              borderSide: const BorderSide(
                                  color: Color(0xff951B80), width: 1.0)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2.0)),
                          hintStyle:
                              GoogleFonts.urbanist(color: Colors.grey[800]),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                showpass3();
                              },
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Color(0xff951B80),
                              )),
                        ),
                        // decoration: ThemeHelper().textInputDecoration(
                        //     'Password', 'Enter your password'),
                        style: TextStyle(
                            fontSize: size.width * 0.042, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: size.height * 0.022),
                    CheckboxListTile(
                      selectedTileColor: const Color(0XFF7F3DFF),
                      title: Text.rich(
                        TextSpan(
                          text: '',
                          style: TextStyle(fontSize: size.width * 0.036),
                          children: const [
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
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    SizedBox(height: size.height * 0.038),
                    Column(
                      children: [
                        SizedBox(
                            height: size.height * 0.065,
                            width: size.width * 0.55,
                            child: ElevatedButton(
                              onPressed: () async {
                                String emailText = email.text;
                                String passwordText = password.text;

                                if (!emailText.contains('@') ||
                                    !emailText.contains('.') ||
                                    passwordText.length < 6 ||
                                    (isChecked != null && !isChecked!)) {
                                  String warningMessage = '';

                                  if (!emailText.contains('@') ||
                                      !emailText.contains('.')) {
                                    warningMessage += 'Invalid email format\n';
                                  } else if (passwordText.length < 6) {
                                    warningMessage +=
                                        'Password must be at least 6 characters\n';
                                  } else if (isChecked != null && !isChecked!) {
                                    warningMessage +=
                                        'Please accept terms and conditions\n';
                                  }

                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text('Warning'),
                                      content: Text(warningMessage),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen(
                                              email: email.text,
                                              passkey: password.text,
                                            )),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.042),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Continue",
                                    style: GoogleFonts.poppins(
                                        fontSize: size.width * 0.038,
                                        color: theme.disabledColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_sharp,
                                      color: Colors.black),
                                ],
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: size.height * 0.024),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Or",
                          style: TextStyle(
                            color: Color(0XFF91919F),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.095),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.042),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: GoogleFonts.inter(
                                color: const Color(0XFF91919F),
                                fontWeight: FontWeight.w600,
                                fontSize: size.width * 0.036,
                              ),
                            ),
                            TextSpan(
                              text: 'Login',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Login_Screen()));
                                },
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
