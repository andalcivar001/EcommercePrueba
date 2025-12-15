import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String nombre;
  String? email;
  String? password;
  String? fechaNacimiento;
  String? image;

  User({
    this.id,
    required this.nombre,
    this.email,
    this.password,
    this.fechaNacimiento,
    this.image,
  });

  @override
  String toString() {
    return 'User{id: $id, nombre: $nombre,  email: $email,  password: $password, phone: $password, fechaNacimiento: $fechaNacimiento, image: $image)}}';
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    nombre: json["nombre"],
    email: json["email"],
    password: json["password"] ?? '',
    fechaNacimiento: json["fecha_nacimiento"] ?? '',
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "email": email,
    "password": password,
    "fecha_nacimiento": fechaNacimiento,
    "image": image,
  };
}
