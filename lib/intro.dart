// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping/auth_service/log_in.dart';
import 'package:shopping/auth_service/sign_up.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  Widget button(BuildContext context, String label, Color buttonColor,
      double width, Color textColor) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: buttonColor,
        border: Border.all(color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
      ),
    );
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
              "assets/images/shopping.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: const Color.fromRGBO(1, 1, 1, 0.7),
            height: phoneHeight,
            width: phoneWidth,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: phoneHeight * 0.1),
                const Text(
                  "Literally Everything",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'IBMPlexMono',
                      fontSize: 40,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(height: phoneHeight * 0.01),
                const Text(
                  "Transform your closet and yourself with our wide range of goods by looking good and gaining that extra confidence",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'IBMPlexMono',
                      fontSize: 16,
                      fontWeight: FontWeight.w200),
                ),
                SizedBox(height: phoneHeight * 0.40),
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const LoginScreen(),
                      type: PageTransitionType.topToBottom,
                      duration: const Duration(seconds: 1),
                    ),
                  ),
                  child: button(context, "Log In", Colors.white, phoneWidth,
                      Colors.black),
                ),
                SizedBox(height: phoneHeight * 0.02),
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const SignupScreen(),
                      type: PageTransitionType.bottomToTop,
                      duration: const Duration(seconds: 1),
                    ),
                  ),
                  child: button(context, "Sign Up", Colors.black, phoneWidth,
                      Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
