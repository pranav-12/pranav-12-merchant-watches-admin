import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merchant_watches/domain/product_model/add_product_model/add_product_model.dart';
import 'package:merchant_watches/infrastructure/add_products/add_products.dart';
import 'package:provider/provider.dart';

import '../../appication/add_product_provider.dart';
import '../../constants/constants.dart';

class AddProductCartItems extends StatelessWidget {
  AddProductCartItems({super.key});

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
      body: Provider.of<AddProductProvider>(context).isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<AddProductProvider>(
              builder: (context, value, child) => Form(
                key: value.formKey,
                child: ListView(padding: const EdgeInsets.all(10), children: [
                  TextFormField(
                    controller: value.nameProductController,
                    decoration: const InputDecoration(hintText: 'Product Name'),
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z, ,A-z]"))
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Product name is empty';
                      }
                      return null;
                    },
                  ),
                  ksizedBoxheight10,
                  TextFormField(
                    controller: value.priseProductController,
                    decoration: const InputDecoration(hintText: 'price'),
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Price is empty';
                      }
                      return null;
                    },
                  ),
                  ksizedBoxheight10,
                  TextFormField(
                    controller: value.deliveryfeeProductController,
                    decoration: const InputDecoration(hintText: 'Delivery Fee'),
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Delivery Fee is empty';
                      }
                      return null;
                    },
                  ),
                  ksizedBoxheight10,
                  TextFormField(
                    controller: value.descriptionProductController,
                    decoration: const InputDecoration(hintText: 'Description'),
                    autocorrect: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-z,A-z,0-9]"))
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Description is empty';
                      }
                      return null;
                    },
                    maxLines: 5,
                  ),
                  const CategoryDropDown(),
                  ksizedBoxheight10,
                  IconButton(
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
                    icon: const Icon(Icons.add_a_photo),
                  ),
                  ksizedBoxheight10,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: MediaQuery.of(context).size.width / 3.4,
                    child: value.imagelist.isNotEmpty
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
                                      icon: const Icon(
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
                  ),
                  ksizedBoxheight10,
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 1.5, 50),
                      backgroundColor: primaryBackgroundColor,
                    ),
                    onPressed: () {
                      addProductInBE(value, context);
                    },
                    child: const Text(
                      'Add Product',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
            ),
    );
  }

  Future<void> addProductInBE(
      AddProductProvider value, BuildContext context) async {
    if (value.nameProductController.text.isEmpty &&
        value.priseProductController.text.isEmpty &&
        value.deliveryfeeProductController.text.isEmpty &&
        value.descriptionProductController.text.isEmpty &&
        value.imagelist.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'please fill this required product details',
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          duration: const Duration(seconds: 3),
          // margin: EdgeInsets.all(10),
          padding: const EdgeInsets.all(30),
          backgroundColor: Colors.red,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          behavior: SnackBarBehavior.floating,
          //  animation: ,
        ),
      );
    } else {
      if (value.formKey.currentState!.validate()) {
        try {
          for (var element in value.imagelist) {
            Reference reference =
                FirebaseStorage.instance.ref().child('images/${element.name}');
            await reference.putFile(File(element.path));
            String img = await reference.getDownloadURL();
            log(img);
            value.imageUrls.add(img);
          }

          log("----------imageUrls : ${value.imageUrls}");
        } catch (error) {
          log(error.toString());
        }

        try {
          final newProduct = Product.create(
            name: value.nameProductController.text,
            price: int.parse(value.priseProductController.text),
            description: value.descriptionProductController.text,
            image: value.imageUrls,
            category: value.categoryName,
            deliveryFee: value.deliveryfeeProductController.text,
          );
          // log(newProduct.toString());
          // log(newProduct.name.toString());
          // log(newProduct.price.toString());
          // log(newProduct.description.toString());
          // log(newProduct.image.toString());
          // log(newProduct.category.toString());
          // log(newProduct.deliveryFee.toString());
          value.isLoadingFunc(value: true);
          await AddProductApi.instance.addProduct(newProduct, value);
          value.isLoadingFunc(value: false);
          value.refresh();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              'Product Added Successfully',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            duration: const Duration(seconds: 3),
            // margin: EdgeInsets.all(10),
            padding: const EdgeInsets.all(30),
            backgroundColor: Colors.green,
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            behavior: SnackBarBehavior.floating,
          ));
        } on FormatException catch (e) {
          log(e.message);
        } catch (errMESSAGE) {
          log(errMESSAGE.toString());
        }
      }
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
