// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  String id;
  String nombre;
  String codigoProvincia;
  String codigo;
  bool isActive;

  City({
    required this.id,
    required this.nombre,
    required this.codigoProvincia,
    required this.codigo,
    required this.isActive,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['_id'],
    nombre: json["nombre"],
    codigoProvincia: json["codigoProvincia"],
    codigo: json["codigo"],
    isActive: json["isActive"],
  );

  static List<City> fromJsonList(List<dynamic> jsonList) {
    List<City> toList = [];
    jsonList.forEach((item) {
      City city = City.fromJson(item);
      toList.add(city);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nombre": nombre,
    "codigoProvincia": codigoProvincia,
    "codigo": codigo,
    "isActive": isActive,
  };
}
