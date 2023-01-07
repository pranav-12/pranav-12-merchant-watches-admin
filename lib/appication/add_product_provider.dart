import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:merchant_watches/domain/product_model/add_product_model/add_product_model.dart';
import 'package:merchant_watches/infrastructure/add_products/add_products.dart';

class AddProductProvider with ChangeNotifier {
  int value = 1;
  String? categoryName;
  List imagelist = [];
  List<String> imageUrls = [];
  List<XFile> file = [];
  AddProductModel? product;
  List allProductList = [];
  bool isLoading = false;
  String? result;

  final formKey = GlobalKey<FormState>();
  final nameProductController = TextEditingController();
  final priseProductController = TextEditingController();
  final descriptionProductController = TextEditingController();
  final deliveryfeeProductController = TextEditingController();
  Future getImage(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickMultiImage();

    if (file.length > 4 || imagelist.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only 4 Images can add'),
        ),
      );
      return;
    } else if (imagelist.length + file.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Only ${4 - imagelist.length} more Images can add'),
      ));
      return;
    }

    imagelist.addAll(file);
    log(imagelist.toString());
    notifyListeners();
  }

  void refresh() {
    imagelist.clear();
    imageUrls.clear();
    nameProductController.clear();
    priseProductController.clear();
    deliveryfeeProductController.clear();
    descriptionProductController.clear();
  }

  void isLoadingFunc({
    required bool value,
  }) {
    isLoading = value;
  }

  void deleteImageList(int index) {
    imagelist.removeAt(index);
    notifyListeners();
  }

  void changeCategoryName(String newName) {
    categoryName = newName;
    notifyListeners();
  }

  void changeValue(int newValue) {
    value = newValue;
    notifyListeners();
  }

  void getData() async {
    await AddProductApi().getAllProuct();
    // log('allProductList : $allProductList');
    notifyListeners();
  }
}
