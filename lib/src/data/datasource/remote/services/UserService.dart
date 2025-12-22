import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<String> token;
  UserService(this.token);
  Future<Resource<User>> update(User user, int id) async {
    try {
      Uri url = Uri.http(Apiconfig.API_ECOMMERCE, '/users/$id');
      Map<String, String> headers = {"Content-Type": "application/json"};
      String body = json.encode(user.toJson());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        User userResponse = User.fromJson(data);
        return Success(userResponse);
      } else {
        //print('Error  ${data}');
        return Error(listToString(data['message']));
      }
    } catch (e) {
      print('Error register: $e');
      return Error(e.toString());
    }
  }

  Future<Resource<User>> updateImage(User user, int id, File image) async {
    try {
      Uri url = Uri.http(Apiconfig.API_ECOMMERCE, '/users/$id');
      Map<String, String> headers = {"Content-Type": "application/json"};

      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = await token;

      request.fields['user'] = json.encode({
        'nombre': user.nombre,
        'telefono': user.telefono,
        'fechaNacimiento': user.fechaNacimiento,
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        User userResponse = User.fromJson(data);
        return Success(userResponse);
      } else {
        //print('Error  ${data}');
        return Error(listToString(data['message']));
      }
    } catch (e) {
      print('Error register: $e');
      return Error(e.toString());
    }
  }
}
