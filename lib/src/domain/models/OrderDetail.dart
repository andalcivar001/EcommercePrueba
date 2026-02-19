// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

import 'package:ecommerce_prueba/src/domain/models/Product.dart';

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  String? id;
  String idProducto;
  double precio;
  int cantidad;
  Product? producto;

  OrderDetail({
    this.id,
    required this.idProducto,
    required this.precio,
    required this.cantidad,
    this.producto,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["_id"],
    idProducto: json["idProducto"],
    precio: json["precio"]?.toDouble(),
    cantidad: json["cantidad"],
    producto: json["producto"] != null
        ? Product.fromJson(json["producto"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "idProducto": idProducto,
    "precio": precio,
    "cantidad": cantidad,
    "producto": producto,
  };
}
