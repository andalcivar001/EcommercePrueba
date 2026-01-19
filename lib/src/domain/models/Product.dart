// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String descripcion;
  String? codAlterno;
  String? imagen1;
  int stock;
  String? imagen2;
  String idCategory;
  String idSubcategory;
  bool isActive;

  Product({
    required this.id,
    required this.descripcion,
    this.codAlterno,
    this.imagen1,
    required this.stock,
    this.imagen2,
    required this.idCategory,
    required this.idSubcategory,
    required this.isActive,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    descripcion: json["descripcion"],
    codAlterno: json["codAlterno"] ?? '',
    imagen1: json["imagen1"] ?? '',
    stock: json["stock"],
    imagen2: json["imagen2"] ?? '',
    idCategory: json["idCategory"],
    idSubcategory: json["idSubcategory"],
    isActive: json["isActive"],
  );

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    List<Product> toList = [];
    jsonList.forEach((item) {
      Product category = Product.fromJson(item);
      toList.add(category);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "descripcion": descripcion,
    "codAlterno": codAlterno ?? '',
    "imagen1": imagen1 ?? '',
    "stock": stock,
    "imagen2": imagen2 ?? '',
    "idCategory": idCategory,
    "idSubcategory": idSubcategory,
    "isActive": isActive,
  };
}
