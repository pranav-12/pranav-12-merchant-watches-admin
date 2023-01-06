import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:merchant_watches/appication/add_product_provider.dart';

import 'package:merchant_watches/core/uri.dart';

import 'package:merchant_watches/domain/product_model/add_product_model/add_product_model.dart';

class AddProductApi {
  AddProductApi.internal();
  static AddProductApi instance = AddProductApi.internal();

  AddProductApi factory() {
    return instance;
  }

  final dio = Dio();

  AddProductApi() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }
  Future addProduct(Product value) async {
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
    try {
      Response response = await dio.get(baseUrl + productUrl);
      final getData = AddProductModel.fromJson(response.data);
      AddProductProvider().getAllProductList.add(getData);
      log(AddProductProvider().getAllProductList.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
