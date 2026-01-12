import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SubCategoryFormState extends Equatable {
  final String id;
  final BlocFormItem nombre;
  final BlocFormItem descripcion;
  final String categoria;
  final List<Category>? listCategory;
  final bool isActive;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const SubCategoryFormState({
    this.id = '',
    this.nombre = const BlocFormItem(error: 'Ingrese el nombre'),
    this.descripcion = const BlocFormItem(error: 'Ingrese la descripcion'),
    this.categoria = '',
    this.isActive = true,
    this.response,
    this.formKey,
    this.listCategory = const [],
  });

  SubCategoryFormState copyWith({
    String? id,
    BlocFormItem? nombre,
    BlocFormItem? descripcion,
    String? categoria,
    bool? isActive,
    Resource? response,
    GlobalKey<FormState>? formKey,
    List<Category>? listCategory,
  }) {
    return SubCategoryFormState(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      categoria: categoria ?? this.categoria,
      descripcion: descripcion ?? this.descripcion,
      isActive: isActive ?? this.isActive,
      listCategory: listCategory,
      formKey: formKey,
      response: response,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    nombre,
    descripcion,
    categoria,
    isActive,
    response,
    listCategory,
  ];
}
