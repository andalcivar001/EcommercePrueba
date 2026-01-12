import 'dart:convert';
import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class SubCategoryService {
  Future<String> token;

  SubCategoryService(this.token);
  Future<Resource<List<SubCategory>>> getSubCategories() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/sub-category');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<SubCategory> subCategoryResponse = SubCategory.fromJsonList(data);
        return Success(subCategoryResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<SubCategory>> create(SubCategory subCategory) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/sub-category');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };
      String body = json.encode(subCategory.toJson());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        SubCategory subCategoryResponse = SubCategory.fromJson(data);
        return Success(subCategoryResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<SubCategory>> update(
    SubCategory subCategory,
    String id,
  ) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/sub-category/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };
      String body = json.encode({
        'nombre': subCategory.nombre,
        'descripcion': subCategory.descripcion,
        'idCategory': subCategory.idCategory,
        'isActive': subCategory.isActive,
      });

      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        SubCategory subCategoryResponse = SubCategory.fromJson(data);
        return Success(subCategoryResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<bool>> delete(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/sub-category/$id');
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
