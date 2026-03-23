import 'dart:convert';
import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/FinancialEntities.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class FinancialEntitiesService {
  Future<String> token;

  FinancialEntitiesService(this.token);
  Future<Resource<List<FinancialEntities>>> getFinancialEntities() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/financial-entities');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<FinancialEntities> feResponse = FinancialEntities.fromJsonList(
          data,
        );
        return Success(feResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
