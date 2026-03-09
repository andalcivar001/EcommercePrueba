import 'dart:typed_data';

import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderListState extends Equatable {
  final String busqueda;
  final Resource? response;
  final Resource? responseDelete;
  final List<Order>? listaOrder;
  final GlobalKey<FormState>? formKey;
  final Uint8List? pdfBytes;
  final bool loading;
  final String accion;
  final String pdfNombre;

  OrderListState({
    this.response,
    this.responseDelete,
    this.formKey,
    this.busqueda = '',
    this.listaOrder,
    this.pdfBytes,
    this.loading = false,
    this.accion = '',
    this.pdfNombre = '',
  });

  OrderListState copyWith({
    GlobalKey<FormState>? formKey,
    Resource? response,
    Resource? responseDelete,
    String? busqueda,
    List<Order>? listaOrder,
    bool? loading,
    Uint8List? pdfBytes,
    String? accion,
    String? pdfNombre,
  }) {
    return OrderListState(
      busqueda: busqueda ?? this.busqueda,
      response: response ?? this.response,
      responseDelete: responseDelete,
      formKey: formKey,
      listaOrder: listaOrder ?? this.listaOrder,
      loading: loading ?? this.loading,
      pdfBytes: pdfBytes ?? this.pdfBytes,
      accion: accion ?? this.accion,
      pdfNombre: pdfNombre ?? this.pdfNombre,
    );
  }

  @override
  List<Object?> get props => [
    response,
    responseDelete,
    busqueda,
    listaOrder,
    loading,
    pdfBytes,
    accion,
    pdfNombre,
  ];
}
