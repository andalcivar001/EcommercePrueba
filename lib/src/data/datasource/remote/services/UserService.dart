import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class UserService {
  Future<String> token;

  UserService(this.token);
  Future<Resource<User>> update(User user, String id) async {
    try {
      Uri url = Uri.http(Apiconfig.API_ECOMMERCE, '/users/$id');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };
      String body = json.encode({
        'nombre': user.nombre,
        'telefono': user.telefono,
        'fechaNacimiento': user.fechaNacimiento,
      });

      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        User userResponse = User.fromJson(data);
        return Success(userResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<User>> updateImage(User user, String id, File file) async {
    try {
      Uri url = Uri.http(Apiconfig.API_ECOMMERCE, '/users/upload/$id');

      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = await token;

      request.files.add(
        http.MultipartFile(
          'file',
          http.ByteStream(file.openRead().cast()),
          await file.length(),
          filename: basename(file.path),
          contentType: MediaType('image', 'jpg'),
        ),
      );
      request.fields['user'] = json.encode({
        'nombre': user.nombre,
        'telefono': user.telefono,
        'fechaNacimiento': user.fechaNacimiento,
      });
      final response = await request.send();
      final data = json.decode(
        await response.stream.transform(utf8.decoder).first,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        User userResponse = User.fromJson(data);
        return Success(userResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
