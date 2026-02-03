import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class ClientService {
  Future<String> token;

  ClientService(this.token);

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
        return Success(clientResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Client>> create(Client client) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/client');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };
      String body = json.encode(client.toJson());
      final response = await http.post(url, headers: headers, body: body);
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

  Future<Resource<Client>> update(Client client, String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/client/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };
      String body = json.encode({
        'nombre': client.nombre,
        'tipoIdentificacion': client.tipoIdentificacion,
        'numeroIdentificacion': client.numeroIdentificacion,
        'email': client.email,
        'idProvincia': client.idProvincia,
        'idCiudad': client.idCiudad,
        'direccion': client.direccion,
        'telefono': client.telefono,
        'latitud': client.latitud,
        'longitud': client.longitud,
        'isActive': client.isActive,
      });

      final response = await http.put(url, headers: headers, body: body);
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

  Future<Resource<bool>> delete(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/client/$id');
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
