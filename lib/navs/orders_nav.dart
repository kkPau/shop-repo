import 'package:flutter/material.dart';

// import '../reusables/appbar.dart';
// import '../reusables/drawer.dart';

class OrdersNav extends StatelessWidget {
  const OrdersNav({super.key});

  @override
  Widget build(BuildContext context) {
    // final phoneWidth = MediaQuery.of(context).size.width;

    return const Scaffold(
      backgroundColor: Colors.white,
      // drawer: const DrawerWidget(),
      // appBar: PreferredSize(
      //     preferredSize: Size(phoneWidth, 75), child: const AppBarWidget()),
      body: Center(
        child: Text("Orders"),
      ),
    );
  }
}
