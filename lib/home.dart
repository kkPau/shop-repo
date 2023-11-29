// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shopping/intro.dart';
import 'package:shopping/navs/cart_nav.dart';
import 'package:shopping/reusables/appbar.dart';
import 'package:shopping/reusables/drawer.dart';
import 'package:shopping/navs/home_nav.dart';
import 'package:shopping/navs/orders_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign Out"),
          content: const Text("Are you sure you want to sign out of the app?"),
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

  Widget circleWidget(Widget child) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: child,
    );
  }

  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeNav()},
    {'page': const CartNav()},
    {'page': const OrdersNav()},
  ];

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final user = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width;
    // final phoneHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerWidget(),
      appBar: PreferredSize(
          preferredSize: Size(phoneWidth, 80), child: const AppBarWidget()),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          onTabChange: (index) {
            _selectedPage(index);
          },
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          selectedIndex: _selectedPageIndex,
          curve: Curves.bounceInOut,
          haptic: true,
          gap: 10,
          tabBorder: Border.all(color: Colors.black, width: 3),
          backgroundColor: Colors.white,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
              iconColor: Colors.black,
              textColor: Colors.black,
            ),
            GButton(
              icon: Icons.shopping_cart,
              text: 'Cart',
              iconColor: Colors.black,
              textColor: Colors.black,
            ),
            GButton(
              icon: Icons.shopping_bag,
              text: 'Orders',
              iconColor: Colors.black,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
    );
  }
}
