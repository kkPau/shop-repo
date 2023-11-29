import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final item;
  const Item({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final phoneWidth = MediaQuery.of(context).size.width;
    final phoneHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        Image.network(
          item["images"][0],
          fit: BoxFit.fill,
        ),
        Positioned(
          top: 1,
          child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: phoneWidth,
              padding: const EdgeInsets.all(20),
              color: const Color.fromRGBO(255, 255, 255, 1.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item["name"],
                        style: const TextStyle(
                            fontFamily: "DMSerifDisplay",
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      item["price"],
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(height: phoneHeight * 0.015),
                Row(
                  children: [
                    const Text(
                      "Size: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: phoneWidth * 0.02),
                    sizebox("S"),
                    SizedBox(width: phoneWidth * 0.02),
                    sizebox("M"),
                    SizedBox(width: phoneWidth * 0.02),
                    sizebox("L"),
                    SizedBox(width: phoneWidth * 0.02),
                    sizebox("XL"),
                  ],
                ),
                SizedBox(height: phoneHeight * 0.015),
                Text(
                  item["description"],
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(height: phoneHeight * 0.015),
                button(phoneWidth, "Add to Cart"),
              ]),
            ),
          ],
        ),
      ])
          // Column(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         decoration: const BoxDecoration(
          //           color: Color.fromARGB(255, 239, 232, 222),
          //           borderRadius:
          //               BorderRadius.only(bottomLeft: Radius.circular(60)),
          //         ),
          //         child: Column(
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 45),
          //               child: Text(
          //                 item["name"],
          //                 style: const TextStyle(
          //                     fontFamily: "DMSerifDisplay",
          //                     fontSize: 35,
          //                     fontWeight: FontWeight.w600),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 20),
          //               child: Image.network(item["images"][0],
          //                   height: phoneHeight * 0.45),
          //             ),
          //             SizedBox(height: phoneHeight * 0.01),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 45),
          //               child: Text(
          //                 item["description"],
          //                 style: const TextStyle(fontSize: 16),
          //               ),
          //             ),
          //             SizedBox(height: phoneHeight * 0.01),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 45),
          //               child: Text(
          //                 item["price"],
          //                 style: const TextStyle(
          //                     fontSize: 25, fontWeight: FontWeight.w700),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     Container(
          //       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          //       color: Colors.white,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           button(phoneWidth * 0.4, "CHOOSE SIZE"),
          //           button(phoneWidth * 0.4, "ADD TO CART"),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}

Widget button(double width, String label) {
  return Container(
    width: width,
    decoration: const BoxDecoration(
      // borderRadius: BorderRadius.circular(20),
      color: Color.fromARGB(255, 166, 220, 246),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    ),
  );
}

Widget sizebox(String size) {
  return Container(
    alignment: Alignment.center,
    height: 40,
    width: 40,
    decoration:
        BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
    padding: const EdgeInsets.all(8),
    child: Text(
      size,
      style: const TextStyle(fontWeight: FontWeight.w700),
    ),
  );
}
