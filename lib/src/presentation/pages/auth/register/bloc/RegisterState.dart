import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RegisterState extends Equatable {
  final BlocFormItem nombre;
  final BlocFormItem email;
  final BlocFormItem password;
  final BlocFormItem confirmPassword;
  final BlocFormItem fechaNacimiento;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const RegisterState({
    this.nombre = const BlocFormItem(error: 'Ingrese nombre'),
    this.email = const BlocFormItem(error: 'Ingrese email'),
    this.password = const BlocFormItem(error: 'Ingrese password'),
    this.confirmPassword = const BlocFormItem(
      error: 'Ingrese la confirmacion de password',
    ),
    this.fechaNacimiento = const BlocFormItem(
      error: 'Ingrese fecha de nacimiento',
    ),
    this.response,
    this.formKey,
  });

  toUser() => User(
    nombre: nombre.value,
    email: email.value,
    password: password.value,
    fechaNacimiento: fechaNacimiento.value,
  );

  RegisterState coypWith({
    BlocFormItem? nombre,
    BlocFormItem? email,
    BlocFormItem? password,
    BlocFormItem? confirmPassword,
    BlocFormItem? fechaNacimiento,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }) {
    return RegisterState(
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      response: response,
      formKey: formKey,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    nombre,
    email,
    password,
    confirmPassword,
    fechaNacimiento,
    response,
  ];
}
