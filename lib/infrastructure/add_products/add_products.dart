import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:merchant_watches/core/uri.dart';

import 'package:merchant_watches/domain/product_model/add_product_model/add_product_model.dart';

import '../../appication/add_product_provider.dart';

ValueNotifier<List> productDataList = ValueNotifier([]);

class AddProductApi {
  AddProductApi.internal();
  static AddProductApi instance = AddProductApi.internal();

  AddProductApi factory() {
    return instance;
  }

  final dio = Dio();
  // List productDataList = [];
  AddProductApi() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }
  Future addProduct(Product value, AddProductProvider value1) async {
    try {
      log(baseUrl + productUrl);
      log('Model to Json : ${value.toJson()}');
      Response response = await dio.post(
        options: Options(listFormat: ListFormat.multiCompatible),
        baseUrl + productUrl,
        data: value.toJson(),
      );

      log('result: $response.data');
      // AddProdectModel.fromJson(response.data as Map<String, dynamic>);

      log(response.toString());
      log('Product Added SuccessFully');
    } on DioError catch (e) {
      log(e.error);
    } catch (e) {
      log('error: $e');
      return null;
    }
  }

  Future getAllProuct() async {
    // log('ProductList : $productDataList.value');
    try {
      // log(baseUrl + productUrl);
      Response response = await dio.get(baseUrl + productUrl);
      // log(response.data);

      final getData = AddProductModel.fromJson(jsonDecode(response.data));
      productDataList.value.clear();
      productDataList.value.addAll(getData.products.reversed);
      productDataList.notifyListeners();
      // log(productDataList.value.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteAProduct(String id, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.grey.shade200,
          title: const Text(
            'Are you sure?',
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
                onPressed: () async {
                  String deleteUrl = "/$id";
                  log(baseUrl + productUrl + deleteUrl);
                  try {
                    await dio.delete(baseUrl + productUrl + deleteUrl);
                    getAllProuct();
                  } on DioError catch (err) {
                    log(err.message);
                  } catch (e) {
                    log("error catch on delete a product : $e");
                  }
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        );
      },
    );
  }
}
