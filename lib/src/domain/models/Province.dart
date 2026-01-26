// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
  String nombre;
  String codigoProvincia;
  bool? isActive;

  Province({
    required this.nombre,
    required this.codigoProvincia,
    this.isActive,
  });

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    nombre: json["nombre"],
    codigoProvincia: json["codigoProvincia"],
    isActive: json["isActive"] ?? true,
  );

  static List<Province> fromJsonList(List<dynamic> jsonList) {
    List<Province> toList = [];
    jsonList.forEach((item) {
      Province province = Province.fromJson(item);
      toList.add(province);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "codigoProvincia": codigoProvincia,
    "isActive": isActive ?? true,
  };
}
