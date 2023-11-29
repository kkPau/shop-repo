import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';

import '../models/item.dart';
import '../reusables/appbar.dart';
import '../reusables/drawer.dart';

class NecklaceCategory extends StatelessWidget {
  const NecklaceCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width;
    final phoneHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const DrawerWidget(),
        appBar: PreferredSize(
            preferredSize: Size(phoneWidth, 80), child: const AppBarWidget()),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 15, bottom: 8),
                child: Text(
                  "Chains",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "DMSerifDisplay",
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(child: grid("Chains", phoneWidth, phoneHeight)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget grid(String secondCol, double width, double height) {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Inventory")
          .doc("Necklaces")
          .collection(secondCol)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final inventoryData = snapshot.data!.docs;
          return MasonryGridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: true,
            addAutomaticKeepAlives: true,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: inventoryData.length,
            itemBuilder: (context, index) {
              final item = inventoryData[index] as Map;
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    PageTransition(
                        child: Item(
                          item: item,
                        ),
                        type: PageTransitionType.rightToLeft),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        children: [
                          Image.network(inventoryData[index]["images"][0]),
                          Container(
                            width: width * 0.5,
                            color: const Color.fromRGBO(255, 184, 145, 1.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    inventoryData[index]["name"],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Text(
                                    inventoryData[index]["price"],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.favorite_border),
                                      Icon(Icons
                                          .shopping_cart_checkout_outlined),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            },
          );
        }
        return const CircularProgressIndicator(
          color: Colors.black,
        );
      });
}
