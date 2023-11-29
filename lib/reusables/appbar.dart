import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../intro.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void logOut(BuildContext context) async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Sign Out"),
            content:
                const Text("Are you sure you want to sign out of the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushAndRemoveUntil(
                        PageTransition(
                            child: const Intro(),
                            type: PageTransitionType.leftToRight),
                        (route) => false);
                  },
                  child: const Text("Yes"))
            ],
          );
        },
      );
    }

    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      toolbarHeight: 78,
      elevation: 0,
      centerTitle: true,
      // leading: Icon(Icons.arrow_back_ios_new_outlined),
      titleTextStyle: const TextStyle(color: Colors.black),
      title: const Column(
        children: [
          Text(
            "Literally",
            style: TextStyle(
                fontFamily: "PT_Serif-Web",
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
          Text(
            "Everything",
            style: TextStyle(
                fontFamily: "PT_Serif-Web",
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: InkWell(
            onTap: () => logOut(context),
            child: const Icon(
              Icons.logout_outlined,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
