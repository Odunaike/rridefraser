import 'dart:convert';

import 'package:http/http.dart';
import 'package:rridefraser/data/network/NetworkHelper.dart';
import 'package:rridefraser/domain/product.dart';

class NetworkRepository {
  Future<String> login(
      {required String username, required String password}) async {
    try {
      Response networkResponse = await NetworkHelper.makeloginRequest(
          username: username, password: password);
      if (networkResponse.statusCode == 200) {
        Map<String, dynamic> bodyMap = jsonDecode(networkResponse.body);
        String token = bodyMap["token"] ?? "empty token";
        return token;
      } else if (networkResponse.statusCode == 404) {
        throw "User not found. recheck email";
      } else if (networkResponse.statusCode == 401) {
        throw "Incorrect password";
      } else {
        throw "Server Error occured, try again";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> retrieveUserProduct({required String token}) async {
    try {
      Response networkResponse =
          await NetworkHelper.makeProductRequest(token: token);
      if (networkResponse.statusCode == 200) {
        ProductModel productModel =
            ProductModel.fromRawJson(networkResponse.body);
        return productModel.products;
      } else {
        throw "Error fetching products";
      }
    } catch (e) {
      rethrow;
    }
  }
}
