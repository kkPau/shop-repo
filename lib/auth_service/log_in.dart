// ignore_for_file: sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping/home.dart';
import 'package:shopping/intro.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = true;

  Widget textbox(String hint, Widget? icon, TextInputType keytype,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      keyboardType: keytype,
      obscureText: controller == passwordController ? isVisible : false,
      decoration: InputDecoration(
        suffix: icon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 5,
            color: Color.fromARGB(255, 166, 220, 246),
          ),
        ),
      ),
    );
  }

  Widget button(double width) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 166, 220, 246),
        border: Border.all(color: Colors.white, width: 5),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
      ),
    );
  }

  // Widget errorDiag(String message) {
  //   return AlertDialog(
  //     title: const Text("Error"),
  //     content: Text(message),
  //     actions: [
  //       TextButton(
  //         onPressed: Navigator.of(context).pop,
  //         child: const Text(
  //           'Ok',
  //           style: TextStyle(color: Colors.black),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget errorDiag(String message) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  void logIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Logged in as ${emailController.text}",
            style: const TextStyle(fontSize: 16),
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        PageTransition(
            child: const HomePage(), type: PageTransitionType.rightToLeft),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "invalid-email") {
        errorDiag("Email provided is invalid");
      } else if (e.code == "wrong-password") {
        errorDiag("Password provided is wrong");
      } else if (e.code == "user-not-found") {
        errorDiag("User not found");
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        errorDiag("Invalid credentials");
      } else {
        errorDiag("An error occurred. Try again");
      }
    }

    //     .then(
    //   (value) {
    //     Navigator.of(context).pushReplacement(
    //       PageTransition(
    //           child: const HomePage(), type: PageTransitionType.rightToLeft),
    //     );
    //   },
    // ).onError((error, stackTrace) {
    //   print(error.toString());
    //   if (error == 'The email address is badly formatted.') {
    //     errorDiag("The email provided is invalid");
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    var phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: phoneHeight,
            width: phoneWidth,
            child: Image.asset(
              'assets/images/shopping.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: const Color.fromRGBO(1, 1, 1, 0.6),
            height: phoneHeight,
            width: phoneWidth,
          ),
          Column(
            children: [
              SizedBox(height: phoneHeight * 0.04),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Align(
                  alignment: const Alignment(1, -1),
                  child: InkWell(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: const Intro(),
                        type: PageTransitionType.bottomToTop,
                        duration: const Duration(seconds: 1),
                      ),
                    ),
                    child: Stack(alignment: const Alignment(0, 0), children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 166, 220, 246),
                        ),
                        height: 45,
                        width: 45,
                      ),
                      Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(4, 9, 88, 1),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                          weight: 50,
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              SizedBox(height: phoneHeight * 0.02),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text(
                  "Hi, Hello and Welcome!",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "IBMPlexMono",
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: phoneHeight * 0.02),
              Expanded(
                child: Container(
                  width: phoneWidth,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(1, 1, 1, 0.8),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      border: Border.all(color: Colors.white, width: 3)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: phoneHeight * 0.02),
                          const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: phoneHeight * 0.05),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Email address",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: phoneHeight * 0.01),
                          textbox("email@gmail.com", null,
                              TextInputType.emailAddress, emailController),
                          SizedBox(height: phoneHeight * 0.04),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: phoneHeight * 0.01),
                          textbox(
                              "password",
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  child: Icon(
                                    isVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                    size: 18,
                                  )),
                              TextInputType.visiblePassword,
                              passwordController),
                          SizedBox(height: phoneHeight * 0.03),
                          const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 166, 220, 246),
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: phoneHeight * 0.05),
                          InkWell(
                            onTap: () => logIn(),
                            child: button(phoneWidth),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
