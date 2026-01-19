import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<String> token;

  ProductService(this.token);
  Future<Resource<List<Product>>> getProducts() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/products');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<Product> productResponse = Product.fromJsonList(data);
        return Success(productResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Product>> getProductById(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/products/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Product productResponse = Product.fromJson(data);
        return Success(productResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<bool>> delete(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/products/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.delete(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        bool deletedResponse = data as bool;
        return Success(deletedResponse);
      } else {
        return Error(listToString(data));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
