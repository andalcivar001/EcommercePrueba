import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class ProductService {
  Future<String> token;

  ProductService(this.token);
  Future<Resource<List<Product>>> getProducts() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/products');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<Product> productResponse = Product.fromJsonList(data);
        return Success(productResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Product>> getProductById(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/products/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Product productResponse = Product.fromJson(data);
        return Success(productResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Product>> create(
    Product product,
    File? file1,
    File? file2,
  ) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/products');

      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = await token;

      if (file1 != null) {
        request.files.add(
          http.MultipartFile(
            'file1',
            http.ByteStream(file1.openRead().cast()),
            await file1.length(),
            filename: basename(file1.path),
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }

      if (file2 != null) {
        request.files.add(
          http.MultipartFile(
            'file2',
            http.ByteStream(file2.openRead().cast()),
            await file2.length(),
            filename: basename(file2.path),
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }
      request.fields['descripcion'] = product.descripcion;
      request.fields['codAlterno'] = product.codAlterno ?? '';
      request.fields['stock'] = product.stock.toString();
      request.fields['idCategory'] = product.idCategory;
      request.fields['idSubcategory'] = product.idSubcategory;
      request.fields['isActive'] = product.isActive.toString();
      request.fields['precio'] = product.precio.toString();

      print('REQUEST CREAR PRODUCTO ${request.files} ');
      final response = await request.send();
      final data = json.decode(
        await response.stream.transform(utf8.decoder).first,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        Product productResponse = Product.fromJson(data);
        return Success(productResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<Product>> update(
    Product product,
    String id,
    File? file1,
    File? file2,
  ) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/products/$id');

      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = await token;

      if (file1 != null) {
        request.files.add(
          http.MultipartFile(
            'file1',
            http.ByteStream(file1.openRead().cast()),
            await file1.length(),
            filename: basename(file1.path),
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }

      if (file2 != null) {
        request.files.add(
          http.MultipartFile(
            'file2',
            http.ByteStream(file2.openRead().cast()),
            await file2.length(),
            filename: basename(file2.path),
            contentType: MediaType('image', 'jpg'),
          ),
        );
      }

      // request.fields['product'] = json.encode({
      //   'descripcion': product.descripcion,
      //   'codAlterno': product.codAlterno,
      //   'stock': product.stock,
      //   'idCategory': product.idCategory,
      //   'idSubcategory': product.idSubcategory,
      //   'isActive': product.isActive,
      // });
      request.fields['descripcion'] = product.descripcion;
      request.fields['codAlterno'] = product.codAlterno ?? '';
      request.fields['stock'] = product.stock.toString();
      request.fields['idCategory'] = product.idCategory;
      request.fields['idSubcategory'] = product.idSubcategory;
      request.fields['isActive'] = product.isActive.toString();
      request.fields['precio'] = product.precio.toString();

      final response = await request.send();
      final data = json.decode(
        await response.stream.transform(utf8.decoder).first,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        Product productResponse = Product.fromJson(data);
        return Success(productResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<bool>> delete(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/products/$id');
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
