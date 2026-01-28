import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/City.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class CityService {
  Future<String> token;

  CityService(this.token);

  Future<Resource<List<City>>> getCities() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/cities');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<City> cityResponse = City.fromJsonList(data);
        return Success(cityResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<List<City>>> getCitiesByProvince(String idProvince) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/cities/$idProvince');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<City> cityResponse = City.fromJsonList(data);
        return Success(cityResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
