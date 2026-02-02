import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/Province.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class ProvinceService {
  Future<String> token;

  ProvinceService(this.token);
  Future<Resource<List<Province>>> getProvinces() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/province');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<Province> provinceResponse = Province.fromJsonList(data);
        return Success(provinceResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      print('ERROR SERVICE PROVINCE ${e.toString()}');
      return Error(e.toString());
    }
  }

  Future<Resource<Province>> getProvinceById(String idProvince) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/province/$idProvince');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Province provinceResponse = Province.fromJson(data);
        return Success(provinceResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
