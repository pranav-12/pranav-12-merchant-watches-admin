import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:merchant_watches/core/uri.dart';
import 'package:merchant_watches/domain/add_product_model/add_prodect_model/add_prodect_model.dart';

class AddProductApi {
  AddProductApi.internal();
  static AddProductApi instance = AddProductApi.internal();

  AddProductApi factory() {
    return instance;
  }

  final dio = Dio();
  // final url = Url();

  AddProductApi() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
    );
  }
  Future<AddProdectModel?> addProduct(AddProdectModel value) async {
    try {
      log(baseUrl + addProductUrl);
      log('Model to Json : ' + value.toJson().toString());
      Response response = await dio.post(options: Options(listFormat: ListFormat.multiCompatible),
        baseUrl + addProductUrl,
        data: value.toJson(),
      );
      
      log('result: ' + response.data);
      final product =
          AddProdectModel.fromJson(response.data as Map<String, dynamic>);
      log('prodeucr: ' + product.toJson().toString());
      return product;
    } catch (e) {
      log('error: ' + e.toString());
      return null;
    }
  }
}
