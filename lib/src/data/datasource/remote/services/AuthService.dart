import 'dart:convert';
import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Resource<AuthResponse>> login(String email, String password) async {
    try {
      Uri url = Uri.http(Apiconfig.API_ECOMMERCE, '/auth/login');
      Map<String, String> headers = {"Content-Type": "application/json"};
      String body = json.encode({'email': email, 'password': password});
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      print('LOGIN SERVICE DATA $data');
      if (response.statusCode == 201 || response.statusCode == 200) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        print('LOGIN SERVICE AUTHRESPONSE $authResponse');
        return Success(authResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return Error(e.toString());
    }
  }

  Future<Resource<AuthResponse>> register(User user) async {
    try {
      Uri url = Uri.http(Apiconfig.API_ECOMMERCE, '/auth/register');
      Map<String, String> headers = {"Content-Type": "application/json"};
      String body = json.encode(user.toJson());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        return Success(authResponse);
      } else {
        //print('Error  ${data}');
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
