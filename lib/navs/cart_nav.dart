import 'package:flutter/material.dart';

// import '../reusables/appbar.dart';
// import '../reusables/drawer.dart';

class CartNav extends StatelessWidget {
  const CartNav({super.key});

  @override
  Widget build(BuildContext context) {
    // final phoneWidth = MediaQuery.of(context).size.width;

    return const Scaffold(
      backgroundColor: Colors.white,
      // drawer: const DrawerWidget(),
      // appBar: PreferredSize(
      //     preferredSize: Size(phoneWidth, 75), child: AppBarWidget()),
      body: Center(
        child: Text("Cart"),
      ),
    );
  }
}
