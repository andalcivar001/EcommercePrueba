// To parse this JSON data, do
//
//     final subCategory = subCategoryFromJson(jsonString);

import 'dart:convert';

SubCategory subCategoryFromJson(String str) =>
    SubCategory.fromJson(json.decode(str));

String subCategoryToJson(SubCategory data) => json.encode(data.toJson());

class SubCategory {
  String nombre;
  String? descripcion;
  String idCategory;
  bool isActive;

  SubCategory({
    required this.nombre,
    this.descripcion,
    required this.idCategory,
    required this.isActive,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    nombre: json["nombre"],
    descripcion: json["descripcion"] ?? '',
    idCategory: json["idCategory"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "descripcion": descripcion ?? '',
    "idCategory": idCategory,
    "isActive": isActive,
  };

  static List<SubCategory> fromJsonList(List<dynamic> jsonList) {
    List<SubCategory> toList = [];
    jsonList.forEach((item) {
      SubCategory category = SubCategory.fromJson(item);
      toList.add(category);
    });
    return toList;
  }
}
