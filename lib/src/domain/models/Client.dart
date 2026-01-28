// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  String id;
  String nombre;
  String tipoIdentificacion;
  String numeroIdentificacion;
  String email;
  String? direccion;
  String? telefono;
  String idProvincia;
  String idCiudad;
  double? latitud;
  double? longitud;
  bool? isActive;

  Client({
    required this.id,
    required this.nombre,
    required this.tipoIdentificacion,
    required this.numeroIdentificacion,
    required this.email,
    this.direccion,
    this.telefono,
    required this.idProvincia,
    required this.idCiudad,
    this.latitud,
    this.longitud,
    this.isActive,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["_id"],
    nombre: json["nombre"],
    tipoIdentificacion: json["tipoIdentificacion"],
    numeroIdentificacion: json["numeroIdentificacion"],
    email: json["email"],
    direccion: json["direccion"] ?? '',
    telefono: json["telefono"] ?? '',
    idProvincia: json["idProvincia"],
    idCiudad: json["idCiudad"],
    latitud: json["latitud"]?.toDouble(),
    longitud: json["longitud"]?.toDouble(),
    isActive: json["isActive"] ?? true,
  );

  static List<Client> fromJsonList(List<dynamic> jsonList) {
    List<Client> toList = [];
    jsonList.forEach((item) {
      Client client = Client.fromJson(item);
      toList.add(client);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nombre": nombre,
    "tipoIdentificacion": tipoIdentificacion,
    "numeroIdentificacion": numeroIdentificacion,
    "email": email,
    "direccion": direccion ?? '',
    "telefono": telefono ?? '',
    "idProvincia": idProvincia,
    "idCiudad": idCiudad,
    "latitud": latitud,
    "longitud": longitud,
    "isActive": isActive ?? true,
  };
}
