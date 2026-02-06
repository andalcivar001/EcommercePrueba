// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:ecommerce_prueba/src/domain/models/OrderDetail.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String? id;
  DateTime fecha;
  String idCliente;
  double latitud;
  double longitud;
  List<OrderDetail> detalles;

  Order({
    this.id,
    required this.fecha,
    required this.idCliente,
    required this.latitud,
    required this.longitud,
    required this.detalles,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["_id"],
    fecha: DateTime.parse(json["fecha"]),
    idCliente: json["idCliente"],
    latitud: json["latitud"]?.toDouble(),
    longitud: json["longitud"]?.toDouble(),
    detalles: (json["detalles"] as List)
        .map((x) => OrderDetail.fromJson(x))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fecha": fecha.toIso8601String(),
    "idCliente": idCliente,
    "latitud": latitud,
    "longitud": longitud,
    "detalles": detalles.map((x) => x.toJson()).toList(),
  };

  static List<Order> fromJsonList(List<dynamic> jsonList) {
    List<Order> toList = [];
    jsonList.forEach((item) {
      Order client = Order.fromJson(item);
      toList.add(client);
    });
    return toList;
  }
}
