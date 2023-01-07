import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/appication/add_product_provider.dart';
import 'package:merchant_watches/constants/constants.dart';
import 'package:merchant_watches/infrastructure/add_products/add_products.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AddProductProvider().getData();

    return Scaffold(
// Appbar
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('All Products'),
            SizedBox(height: 40, child: Image.asset("assets/cart/bag.png"))
          ],
        ),
      ),
// body
      body: ListView(children: [
        ValueListenableBuilder(
          valueListenable: productDataList,
          builder: (context, value, child) => ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  color: cartImageColor,
                  margin: const EdgeInsets.all(10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // Row Contains the images and remove icon
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height / 5,
                          width: size.width / 3,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(
                            value[0]["image"][index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        ksizedBoxWidth10,
                        // Expanded the full details about the cart
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row contains the Brand Name and WishList icon
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value[index]["name"]
                                        .toString()
                                        .toUpperCase(),
                                    overflow: TextOverflow.ellipsis,

                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      AddProductApi()
                                          .deleteAProduct(value[index]['_id'],context);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.clear_circled_solid,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                              // The Text for Color of the watch
                              Text(
                                value[index]["description"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              // row Contains the Rate and qty of the Watch
                              ksizedBoxheight10,
                              Text(
                                "₹ ${value[index]["price"]}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 0,
                  ),
              itemCount: value.length),
        ),
      ]),
    );
  }
}
