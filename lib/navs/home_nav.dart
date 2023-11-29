// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping/categories/bottoms_category.dart';
import 'package:shopping/categories/necklace_category.dart';
import 'package:shopping/categories/ring_category.dart';
import 'package:shopping/categories/tops_category.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  Widget categoryView(double height, double width, String label, String doc,
      String secondCol, Function()? onTap) {
    return Column(
      children: [
        SizedBox(height: height * 0.03),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "IBMPlexMono",
                    fontWeight: FontWeight.w700),
              ),
              InkWell(
                onTap: onTap,
                child: const Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "IBMPlexMono",
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.01),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Inventory")
              .doc(doc)
              .collection(secondCol)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: height * 0.4,
                width: width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...snapshot.data!.docs.map(
                      (doc) {
                        final inventoryData =
                            doc.data() as Map<String, dynamic>;
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 3)),
                          margin: const EdgeInsets.all(8),
                          height: height * 0.4,
                          width: width * 0.65,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: Stack(
                              children: [
                                Container(
                                  height: height * 0.4,
                                  width: width * 0.7,
                                  child: Image.network(
                                    inventoryData["images"][0],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: width * 0.7,
                                    color: const Color.fromRGBO(
                                        255, 184, 145, 0.8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        inventoryData["name"],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   bottom: 0.0,
                                //   child: Container(
                                //     padding: const EdgeInsets.all(10),
                                //     width: width * 0.7,
                                //     decoration: const BoxDecoration(
                                //       color: Color.fromRGBO(0, 0, 0, 0.5),
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceEvenly,
                                //       children: [
                                //         Text(
                                //           inventoryData["price"],
                                //           style: const TextStyle(
                                //             fontSize: 20,
                                //             fontFamily: "IBMPlexMono",
                                //             fontWeight: FontWeight.w800,
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //         const Icon(
                                //           Icons.shopping_cart_outlined,
                                //           size: 30,
                                //           weight: 3,
                                //           color: Colors.white,
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    var phoneWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            categoryView(phoneHeight, phoneWidth, "Tops", "Tops", "Jackets",
                () {
              Navigator.push(
                context,
                PageTransition(
                    child: const TopsCategory(),
                    type: PageTransitionType.rightToLeft),
              );
            }),
            categoryView(
                phoneHeight, phoneWidth, "Bottoms", "Bottoms", "Denim Shorts",
                () {
              Navigator.push(
                context,
                PageTransition(
                    child: const BottomsCategory(),
                    type: PageTransitionType.rightToLeft),
              );
            }),
            categoryView(
                phoneHeight, phoneWidth, "Necklaces", "Necklaces", "Chains",
                () {
              Navigator.push(
                context,
                PageTransition(
                    child: const NecklaceCategory(),
                    type: PageTransitionType.rightToLeft),
              );
            }),
            categoryView(
                phoneHeight, phoneWidth, "Rings", "Rings", "Male Rings", () {
              Navigator.push(
                context,
                PageTransition(
                    child: const RingCategory(),
                    type: PageTransitionType.rightToLeft),
              );
            }),
          ],
        ),
      ),
    );
  }
}
