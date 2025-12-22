import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileState extends Equatable {
  final int id;
  final BlocFormItem nombre;
  final BlocFormItem telefono;
  final BlocFormItem fechaNacimiento;
  final GlobalKey<FormState>? formKey;
  final File? image;
  final Resource? response;
  final User? user;

  const ProfileState({
    this.id = 0,
    this.nombre = const BlocFormItem(error: 'Ingrese el nombre'),
    this.telefono = const BlocFormItem(error: 'Ingrese el telefono'),
    this.fechaNacimiento = const BlocFormItem(
      error: 'Ingrese la fecha de nacimiento',
    ),
    this.formKey,
    this.image,
    this.response,
    this.user,
  });

  ProfileState copyWith({
    int? id,
    BlocFormItem? nombre,
    BlocFormItem? telefono,
    BlocFormItem? fechaNacimiento,
    GlobalKey<FormState>? formKey,
    Resource? response,
    File? image,
    User? user,
  }) {
    return ProfileState(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      image: image ?? this.image,
      formKey: formKey,
      response: response,
      user: user,
    );
  }

  @override
  List<Object?> get props => [nombre, fechaNacimiento, telefono, image, user];
}
