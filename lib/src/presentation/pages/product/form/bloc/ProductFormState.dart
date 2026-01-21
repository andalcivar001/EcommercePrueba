import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/Category.dart';
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
  final String? idSubcategory;
  final Resource? response;
  final Resource? responseCategory;
  final Resource? responseSubcategory;
  final Resource? responseProduct;
  final File? file1;
  final File? file2;
  final GlobalKey<FormState>? formKey;
  final bool isActive;
  final List<Category> listaCategories;
  final List<SubCategory> listaSubCategories;
  final String? imagenUrl1;
  final String? imagenUrl2;

  ProductFormState({
    this.id = '',
    this.descripcion = const BlocFormItem(error: 'Ingrese la descripcion'),
    this.codAlterno,
    this.stock = 0,
    this.idCategory = '',
    this.idSubcategory,
    this.response,
    this.responseCategory,
    this.responseSubcategory,
    this.formKey,
    this.file1,
    this.file2,
    this.responseProduct,
    this.isActive = true,
    this.listaCategories = const [],
    this.listaSubCategories = const [],
    this.imagenUrl1,
    this.imagenUrl2,
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
    Resource? responseProduct,
    bool? isActive,
    List<Category>? listaCategories,
    List<SubCategory>? listaSubCategories,
    String? imagenUrl1,
    String? imagenUrl2,
  }) {
    return ProductFormState(
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
      codAlterno: codAlterno ?? this.codAlterno,
      stock: stock ?? this.stock,
      idCategory: idCategory ?? this.idCategory,
      idSubcategory: idSubcategory ?? this.idSubcategory,
      response: response,
      responseCategory: responseCategory ?? this.responseCategory,
      responseSubcategory: responseSubcategory ?? this.responseSubcategory,
      formKey: formKey,
      file1: file1 ?? this.file1,
      file2: file2 ?? this.file2,
      responseProduct: responseProduct ?? this.responseProduct,
      isActive: isActive ?? this.isActive,
      listaCategories: listaCategories ?? this.listaCategories,
      listaSubCategories: listaSubCategories ?? this.listaSubCategories,
      imagenUrl1: imagenUrl1 ?? this.imagenUrl1,
      imagenUrl2: imagenUrl2 ?? this.imagenUrl2,
    );
  }

  factory ProductFormState.initial() => ProductFormState(
    formKey: GlobalKey<FormState>(),
    descripcion: BlocFormItem(value: ''),
    codAlterno: '',
    stock: 0,
    idCategory: '',
    idSubcategory: '',
    isActive: true,
    listaCategories: [],
    listaSubCategories: [],
    file1: null,
    file2: null,
    imagenUrl1: null,
    imagenUrl2: null,
  );

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
    responseCategory,
    responseSubcategory,
    responseProduct,
    isActive,
    listaCategories,
    listaSubCategories,
    imagenUrl1,
    imagenUrl2,
  ];
}
