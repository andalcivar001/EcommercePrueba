import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  String descripcion;
  bool isActive;

  Category({required this.descripcion, required this.isActive});

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    List<Category> toList = [];
    jsonList.forEach((item) {
      Category category = Category.fromJson(item);
      toList.add(category);
    });
    return toList;
  }

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(descripcion: json["descripcion"], isActive: json["isActive"]);

  Map<String, dynamic> toJson() => {
    "descripcion": descripcion,
    "isActive": isActive,
  };
}
