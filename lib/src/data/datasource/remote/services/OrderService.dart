import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<String> token;

  OrderService(this.token);

  Future<Resource<List<Order>>> getOrderByUser(String idUsuario) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/order/$idUsuario');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<Order> orderResponse = Order.fromJsonList(data);
        return Success(orderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Order>> getOrderById(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/order/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Order orderResponse = Order.fromJson(data);
        return Success(orderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Order>> create(Order order) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/order');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };
      String body = json.encode(order.toJson());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Order orderResponse = Order.fromJson(data);
        return Success(orderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Order>> update(Order order, String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/order/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      //final response = await http.put(url, headers: headers, body: order);
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode(order.toJson()),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Order orderResponse = Order.fromJson(data);
        return Success(orderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<bool>> delete(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/order/$id');
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
