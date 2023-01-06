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
  Future addProduct(AddProdectModel value) async {
    try {
      log(baseUrl + addProductUrl);
      log('Model to Json : ${value.toJson()}');
      Response response = await dio.post(
        options: Options(listFormat: ListFormat.multiCompatible),
        baseUrl + addProductUrl,
        data: value.toJson(),
      );

      log('result: $response.data');
          AddProdectModel.fromJson(response.data as Map<String, dynamic>);


          if (response != null) {
        log(response.toString());
        log('Product Added SuccessFully');
      } else {
        log('product is $response');
        log('Product not Added ');
      }
    } on DioError catch (e) {
      log(e.error);
    } catch (e) {
      log('error: $e');
      return null;
    }
  }
}
