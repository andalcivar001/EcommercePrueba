import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<String> token;

  OrderService(this.token);

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

  Future<Resource<List<Order>>> getOrders() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/Order');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<Order> OrderResponse = Order.fromJsonList(data);
        return Success(OrderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Order>> create(Order Order) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/Order');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };
      String body = json.encode(Order.toJson());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Order OrderResponse = Order.fromJson(data);
        return Success(OrderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Order>> update(Order Order, String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/Order/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };
      String body = json.encode({
        'nombre': Order.nombre,
        'tipoIdentificacion': Order.tipoIdentificacion,
        'numeroIdentificacion': Order.numeroIdentificacion,
        'email': Order.email,
        'idProvincia': Order.idProvincia,
        'idCiudad': Order.idCiudad,
        'direccion': Order.direccion,
        'telefono': Order.telefono,
        'latitud': Order.latitud,
        'longitud': Order.longitud,
        'isActive': Order.isActive,
      });

      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Order OrderResponse = Order.fromJson(data);
        return Success(OrderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<bool>> delete(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/Order/$id');
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
