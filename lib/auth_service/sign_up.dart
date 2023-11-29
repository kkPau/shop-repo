// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping/intro.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isVisible = true;

  Widget textbox(String hint, Widget? icon, TextInputType keytype,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      obscureText: controller == passwordController ? isVisible : false,
      keyboardType: keytype,
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
        color: !checkTerms
            ? Colors.grey
            : const Color.fromARGB(255, 166, 220, 246),
        border: Border.all(color: Colors.white, width: 5),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
      ),
    );
  }

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

  bool checkTerms = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signUp() async {
    try {
      UserCredential userInfo = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userInfo.user!.email)
          .set({
        'Full name': nameController.text,
        'Email': emailController.text,
        'Phone number': phoneController.text,
      });

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const Intro(),
          type: PageTransitionType.topToBottom,
          duration: const Duration(seconds: 1),
        ),
      );

      return userInfo;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
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
            color: const Color.fromRGBO(1, 1, 1, 0.7),
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
                        type: PageTransitionType.topToBottom,
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
              SizedBox(height: phoneHeight * 0.01),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Hey, Stranger!",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "IBMPlexMono",
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Let's get started!",
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
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(1, 1, 1, 0.8),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: phoneHeight * 0.01),
                          const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: phoneHeight * 0.02),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Full name",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          textbox("John Smith", null, TextInputType.name,
                              nameController),
                          SizedBox(height: phoneHeight * 0.02),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Email adress",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          textbox("email@gmail.com", null,
                              TextInputType.emailAddress, emailController),
                          SizedBox(height: phoneHeight * 0.02),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Phone number",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          textbox("+233", null, TextInputType.phone,
                              phoneController),
                          SizedBox(height: phoneHeight * 0.02),
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
                          SizedBox(height: phoneHeight * 0.02),
                          Row(
                            children: [
                              Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.white;
                                  }
                                  return const Color.fromARGB(
                                      255, 166, 220, 246);
                                }),
                                activeColor:
                                    const Color.fromARGB(255, 166, 220, 246),
                                value: checkTerms,
                                onChanged: (value) {
                                  setState(() {
                                    checkTerms = value as bool;
                                  });
                                },
                              ),
                              SizedBox(width: phoneWidth * 0.01),
                              const Text.rich(
                                TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: "Terms and Privacy policy",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 166, 220, 246),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: phoneWidth * 0.05),
                          InkWell(
                            onTap: !checkTerms
                                ? null
                                : () {
                                    try {
                                      signUp();
                                    } catch (e) {
                                      if (e.toString() ==
                                          "email-already-in-use") {
                                        errorDiag(
                                            "Email already exists in database");
                                      } else if (e.toString() ==
                                          "invalid-email") {
                                        errorDiag(
                                            "Email is invalid. Try again");
                                      } else {
                                        errorDiag("An error occurred");
                                      }
                                    }
                                  },
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
