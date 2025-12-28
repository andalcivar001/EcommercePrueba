import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileState extends Equatable {
  final String id;
  final BlocFormItem nombre;
  final BlocFormItem telefono;
  final BlocFormItem fechaNacimiento;
  final GlobalKey<FormState>? formKey;
  final File? imagen;
  final String? imagenUrl;
  final Resource? response;
  final User? user;
  final bool? usuarioActualizado;

  const ProfileState({
    this.id = '',
    this.nombre = const BlocFormItem(error: 'Ingrese el nombre'),
    this.telefono = const BlocFormItem(error: 'Ingrese el telefono'),
    this.fechaNacimiento = const BlocFormItem(
      error: 'Ingrese la fecha de nacimiento',
    ),
    this.formKey,
    this.imagen,
    this.imagenUrl,
    this.response,
    this.user,
    this.usuarioActualizado = false,
  });

  toUser() => User(
    nombre: nombre.value,
    telefono: telefono.value,
    fechaNacimiento: fechaNacimiento.value,
  );

  ProfileState copyWith({
    String? id,
    BlocFormItem? nombre,
    BlocFormItem? telefono,
    BlocFormItem? fechaNacimiento,
    GlobalKey<FormState>? formKey,
    Resource? response,
    File? imagen,
    String? imagenUrl,
    User? user,
    bool? usuarioActualizado,
  }) {
    return ProfileState(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      imagenUrl: imagenUrl ?? this.imagenUrl,
      imagen: imagen ?? this.imagen,
      formKey: formKey,
      response: response,
      user: user ?? this.user,
      usuarioActualizado: usuarioActualizado ?? this.usuarioActualizado,
    );
  }

  @override
  List<Object?> get props => [
    nombre,
    fechaNacimiento,
    telefono,
    imagen,
    user,
    imagenUrl,
    response,
    usuarioActualizado,
  ];
}
