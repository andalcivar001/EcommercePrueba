import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/City.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/Province.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class ClienteService {
  Future<String> token;

  ClienteService(this.token);
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

  Future<Resource<Client>> getClientById(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/client/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Client clientResponse = Client.fromJson(data);
        return Success(clientResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<List<Client>>> getClients() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/client');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<Client> clientResponse = Client.fromJsonList(data);
        print('RESPUESTA CLIENTES: $clientResponse');
        return Success(clientResponse);
      } else {
        print('ERROR CLIENTES: ${data['message']}');
        return Error(listToString(data['message']));
      }
    } catch (e) {
      print('EXCEPCION CLIENTES: $e');
      return Error(e.toString());
    }
  }
}
