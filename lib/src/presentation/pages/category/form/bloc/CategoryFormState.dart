import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryFormState extends Equatable {
  final String id;
  final BlocFormItem nombre;
  final BlocFormItem descripcion;
  final bool isActive;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const CategoryFormState({
    this.id = '',
    this.nombre = const BlocFormItem(error: 'Ingrese nombre'),
    this.descripcion = const BlocFormItem(error: 'Ingrese descripcion'),
    this.response,
    this.formKey,
    this.isActive = false,
  });

  CategoryFormState coypWith({
    String? id,
    BlocFormItem? nombre,
    BlocFormItem? descripcion,
    Resource? response,
    GlobalKey<FormState>? formKey,
    bool? isActive,
  }) {
    return CategoryFormState(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      isActive: isActive ?? this.isActive,
      response: response,
      formKey: formKey,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre, descripcion, isActive, response];
}
