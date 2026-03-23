import 'dart:convert';
import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/PaymentMethod.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class PaymentMethodService {
  Future<String> token;

  PaymentMethodService(this.token);
  Future<Resource<List<PaymentMethod>>> getPaymentMethods() async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/payment-methods');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<PaymentMethod> pmResponse = PaymentMethod.fromJsonList(data);
        return Success(pmResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
