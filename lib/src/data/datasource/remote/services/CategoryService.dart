import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<String> token;

  CategoryService(this.token);
  Future<Resource<List<Category>>> getCategories() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/category');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<Category> categoryResponse = Category.fromJsonList(data);
        return Success(categoryResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
