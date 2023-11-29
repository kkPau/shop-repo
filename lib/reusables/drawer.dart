import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../categories/bottoms_category.dart';
import '../categories/necklace_category.dart';
import '../categories/ring_category.dart';
import '../categories/tops_category.dart';
import '../intro.dart';
import 'package:shopping/navs/cart_nav.dart';
import 'package:shopping/navs/orders_nav.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.email;
    final phoneWidth = MediaQuery.of(context).size.width;
    final phoneHeight = MediaQuery.of(context).size.height;

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

    return Drawer(
      width: phoneWidth * 0.75,
      backgroundColor: const Color.fromRGBO(255, 184, 145, 1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(user)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return UserAccountsDrawerHeader(
                        accountName: Text(
                          userData["Full name"],
                          style: const TextStyle(
                              fontSize: 25,
                              fontFamily: "IBMPlexMono",
                              fontWeight: FontWeight.w800),
                        ),
                        accountEmail: Text(
                          user!,
                          style: const TextStyle(
                              fontSize: 20, fontFamily: "IBMPlexMono"),
                        ),
                        currentAccountPicture: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CircleAvatar(
                            child: ClipOval(
                              child: Image.network(
                                  "https://icon-library.com/images/person-png-icon/person-png-icon-29.jpg"),
                            ),
                          ),
                        ),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://media.istockphoto.com/id/1085287936/photo/milky-way.webp?b=1&s=170667a&w=0&k=20&c=43m9Y8tP_mxMGXfoZLLtv58CQQ7IJt8HwoK-A9mMWiE="),
                              fit: BoxFit.cover),
                        ),
                      );
                    }
                    return const CircularProgressIndicator(
                      color: Colors.black,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.category),
                      SizedBox(width: phoneWidth * 0.02),
                      const Text(
                        "CATEGORIES",
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "IBMPlexMono",
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: phoneHeight * 0.26,
                  width: phoneWidth * 0.70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          // PageTransition(
                          //     child: const TopsCategory(),
                          //     type: PageTransitionType.rightToLeft);
                          Navigator.of(context).push(PageTransition(
                              child: const TopsCategory(),
                              type: PageTransitionType.rightToLeft));
                        },
                        child: const Text(
                          "Tops",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(PageTransition(
                              child: const BottomsCategory(),
                              type: PageTransitionType.rightToLeft));
                        },
                        child: const Text(
                          "Bottoms",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(PageTransition(
                              child: const NecklaceCategory(),
                              type: PageTransitionType.rightToLeft));
                        },
                        child: const Text(
                          "Necklaces",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(PageTransition(
                              child: const RingCategory(),
                              type: PageTransitionType.rightToLeft));
                        },
                        child: const Text(
                          "Rings",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: phoneHeight * 0.03),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_cart_outlined),
                        SizedBox(width: phoneWidth * 0.02),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(PageTransition(
                                child: const CartNav(),
                                type: PageTransitionType.rightToLeft));
                          },
                          child: const Text(
                            "CART",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 25,
                                fontFamily: "IBMPlexMono",
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: phoneHeight * 0.03),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_bag),
                        SizedBox(width: phoneWidth * 0.02),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(PageTransition(
                                child: const OrdersNav(),
                                type: PageTransitionType.rightToLeft));
                          },
                          child: const Text(
                            "ORDERS",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 25,
                                fontFamily: "IBMPlexMono",
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: Row(
              children: [
                const Icon(Icons.logout),
                SizedBox(width: phoneWidth * 0.02),
                TextButton(
                  onPressed: () => logOut(context),
                  child: const Text(
                    "SIGN OUT",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 25,
                        fontFamily: "IBMPlexMono",
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
