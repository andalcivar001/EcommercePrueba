// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  String id;
  String descripcion;
  bool isActive;

  Category({
    required this.id,
    required this.descripcion,
    required this.isActive,
  });

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    List<Category> toList = [];
    jsonList.forEach((item) {
      Category category = Category.fromJson(item);
      toList.add(category);
    });
    return toList;
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    descripcion: json["descripcion"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "descripcion": descripcion,
    "isActive": isActive,
  };
}
