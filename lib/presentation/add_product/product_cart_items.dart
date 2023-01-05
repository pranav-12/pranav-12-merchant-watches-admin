import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:merchant_watches/domain/add_product_model/add_prodect_model/add_prodect_model.dart';
import 'package:merchant_watches/infrastructure/add_products/add_products.dart';
import 'package:provider/provider.dart';

import '../../appication/add_product_provider.dart';
import '../../constants/constants.dart';

class AddProductCartItems extends StatelessWidget {
  AddProductCartItems({super.key});
  final nameProductController = TextEditingController();
  final priseProductController = TextEditingController();
  final descriptionProductController = TextEditingController();
  final deliveryfeeProductController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Add Your Products'),
            SizedBox(height: 40, child: Image.asset("assets/cart/bag.png"))
          ],
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(10), children: [
        TextFormField(
          controller: nameProductController,
          decoration: const InputDecoration(hintText: 'Product Name'),
        ),
        ksizedBoxheight10,
        TextFormField(
          controller: priseProductController,
          decoration: const InputDecoration(hintText: 'price'),
        ),
        ksizedBoxheight10,
        TextFormField(
          controller: deliveryfeeProductController,
          decoration: const InputDecoration(hintText: 'Delivery Fee'),
        ),
        ksizedBoxheight10,
        TextFormField(
          controller: descriptionProductController,
          decoration: const InputDecoration(hintText: 'Description'),
          maxLines: 5,
        ),
        const CategoryDropDown(),
        ksizedBoxheight10,
        Consumer<AddProductProvider>(
          builder: (context, value, child) => IconButton(
              onPressed: () {
                if (value.imagelist.length < 5) {
                  value.getImage(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Only 5 Images can add'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add_a_photo)),
        ),
        ksizedBoxheight10,
        Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.width / 3.4,
            child: Consumer<AddProductProvider>(
              builder: (context, value, child) => value.imagelist.isNotEmpty
                  ? GridView.builder(
                      // dragStartBehavior: DragStartBehavior.down,

                      // scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      itemCount: value.imagelist.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10, crossAxisCount: 4),
                      itemBuilder: (context, index) => Stack(
                        children: [
                          Image.file(
                            File(value.imagelist[index].path),
                          ),
                          Positioned(
                            right: 8,
                            top: -15,
                            child: IconButton(
                                onPressed: () {
                                  value.deleteImageList(index);
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red,
                                )),
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('Select images'),
                    ),
            )),
        ksizedBoxheight10,
        Consumer<AddProductProvider>(
          builder: (context, value, child) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              fixedSize: Size(MediaQuery.of(context).size.width / 1.5, 50),
              backgroundColor: primaryBackgroundColor,
              // padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              addProductInBE(value);
            },
            child: const Text(
              'Add Product',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> addProductInBE(AddProductProvider value) async {
    try {
      log(nameProductController.text.toString());
      log(priseProductController.text.toString());
      log(value.categoryName.toString());
      log(descriptionProductController.text.toString());
      log(value.imagelist.toString());
      log(deliveryfeeProductController.text.toString());
      final newProduct = AddProdectModel.create(
        // id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameProductController.text,
        price: int.parse(priseProductController.text),
        description: descriptionProductController.text,
        image: value.imagelist,
        category: value.categoryName,
        deliveryFee: deliveryfeeProductController.text,
      );
      log(newProduct.toString());
      log(newProduct.name.toString());
      log(newProduct.price.toString());
      log(newProduct.description.toString());
      log(newProduct.image.toString());
      log(newProduct.category.toString());
      log(newProduct.deliveryFee.toString());
      log(' is getted');
      final isAddedProduct =
          await AddProductApi.instance.addProduct(newProduct);
      if (isAddedProduct != null) {
        print('Product Added SuccessFully');
      } else {
        log('safaf ' + isAddedProduct.toString());
        print('Product not Added ');
      }
    } on FormatException {
      const FormatException().message;
    } catch (errMESSAGE) {
      log(errMESSAGE.toString());
    }
  }
}

class CategoryDropDown extends StatelessWidget {
  const CategoryDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddProductProvider>(
      builder: (context, addProductvaluevalue, child) => DropdownButton(
        value: addProductvaluevalue.value,
        items: [
          DropdownMenuItem(
            value: 1,
            child: const Text('Digital'),
            onTap: () {
              addProductvaluevalue.changeCategoryName('Digital');
            },
          ),
          DropdownMenuItem(
            value: 2,
            child: const Text('Analog'),
            onTap: () {
              addProductvaluevalue.changeCategoryName('Analog');
            },
          ),
          DropdownMenuItem(
            value: 3,
            child: const Text('Smart Watches'),
            onTap: () {
              addProductvaluevalue.changeCategoryName('Smart Watches');
            },
          ),
        ],
        onChanged: (value) => addProductvaluevalue.changeValue(value!),
      ),
    );
  }
}
