import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String nombre;
  String? email;
  String? password;
  String? telefono;
  String? fechaNacimiento;
  String? imagen;

  User({
    this.id,
    required this.nombre,
    this.email,
    this.password,
    this.fechaNacimiento,
    this.telefono,
    this.imagen,
  });

  @override
  String toString() {
    return 'User{_id: $id, nombre: $nombre,  email: $email,  password: $password, telefono: $telefono,  fechaNacimiento: $fechaNacimiento, imagen: $imagen)}}';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] ?? 0,
    nombre: json["nombre"] ?? '',
    email: json["email"] ?? '',
    password: json["password"] ?? '',
    telefono: json["telefono"] ?? '',
    fechaNacimiento: json["fechaNacimiento"] ?? '',
    imagen: json["imagen"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nombre": nombre,
    "email": email,
    "password": password,
    "telefono": telefono,
    "fechaNacimiento": fechaNacimiento,
    "imagen": imagen,
  };
}
