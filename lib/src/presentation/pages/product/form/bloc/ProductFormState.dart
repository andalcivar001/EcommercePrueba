import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductFormState extends Equatable {
  final String id;
  final BlocFormItem descripcion;
  final String? codAlterno;
  final int stock;
  final String idCategory;
  final String idSubcategory;
  final Resource? response;
  final Resource? responseCategory;
  final Resource? responseSubcategory;
  final File? file1;
  final File? file2;
  final GlobalKey<FormState>? formKey;
  final List<Category> listaCategorias;
  final List<SubCategory> listaSubcategorias;
  Product? product;

  ProductFormState({
    this.id = '',
    this.descripcion = const BlocFormItem(error: 'Ingrese la descripcion'),
    this.codAlterno,
    this.stock = 0,
    this.idCategory = '',
    this.idSubcategory = '',
    this.response,
    this.responseCategory,
    this.responseSubcategory,
    this.formKey,
    this.file1,
    this.file2,
    this.listaCategorias = const [],
    this.listaSubcategorias = const [],
    this.product,
  });

  ProductFormState copyWith({
    String? id,
    BlocFormItem? descripcion,
    String? codAlterno,
    int? stock,
    String? idCategory,
    String? idSubcategory,
    Resource? response,
    Resource? responseCategory,
    Resource? responseSubcategory,
    GlobalKey<FormState>? formKey,
    File? file1,
    File? file2,
    List<Category>? listaCategorias,
    List<SubCategory>? listaSubcategorias,
    Product? product,
  }) {
    return ProductFormState(
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
      codAlterno: codAlterno ?? this.codAlterno,
      stock: stock ?? this.stock,
      idCategory: idCategory ?? this.idCategory,
      idSubcategory: idSubcategory ?? this.idSubcategory,
      response: response,
      responseCategory: responseCategory,
      responseSubcategory: responseSubcategory,
      formKey: formKey,
      file1: file1 ?? this.file1,
      file2: file2 ?? this.file2,
      listaCategorias: listaCategorias ?? this.listaCategorias,
      listaSubcategorias: listaSubcategorias ?? this.listaSubcategorias,
      product: product,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    descripcion,
    codAlterno,
    stock,
    idCategory,
    idSubcategory,
    response,
    file1,
    file2,
    listaCategorias,
    listaSubcategorias,
    responseCategory,
    responseSubcategory,
    product,
  ];
}
