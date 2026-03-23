import 'package:ecommerce_prueba/src/domain/models/Order.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderPaymentFormState extends Equatable {
  final String? id;
  final String? idOrden;
  final String? metodoPago;
  final double monto;
  final String? referencia;
  final String? entidadFinanciera;
  final String? observaciones;
  final Resource? responseMetodoPago;
  final Resource? responseEntidadFinanciera;
  final Resource? response;
  final GlobalKey<FormState>? formKey;
  final Order? orden;
  final bool loading;

  OrderPaymentFormState({
    this.id,
    this.idOrden,
    this.metodoPago,
    this.monto = 0,
    this.referencia,
    this.entidadFinanciera,
    this.responseMetodoPago,
    this.responseEntidadFinanciera,
    this.response,
    this.observaciones,
    this.formKey,
    this.orden,
    this.loading = false,
  });

  OrderPaymentFormState copyWith({
    String? id,
    String? idOrden,
    String? metodoPago,
    double? monto,
    String? referencia,
    String? entidadFinanciera,
    Resource? responseMetodoPago,
    Resource? responseEntidadFinanciera,
    Resource? response,
    String? observaciones,
    GlobalKey<FormState>? formKey,
    Order? orden,
    bool? loading,
  }) {
    return OrderPaymentFormState(
      id: id ?? this.id,
      idOrden: idOrden ?? this.idOrden,
      metodoPago: metodoPago ?? this.metodoPago,
      monto: monto ?? this.monto,
      referencia: referencia ?? this.referencia,
      entidadFinanciera: entidadFinanciera ?? this.entidadFinanciera,
      observaciones: observaciones ?? this.observaciones,
      responseMetodoPago: responseMetodoPago ?? this.responseMetodoPago,
      responseEntidadFinanciera:
          responseEntidadFinanciera ?? this.responseEntidadFinanciera,
      response: response ?? this.response,
      orden: orden ?? this.orden,
      loading: loading ?? this.loading,
      formKey: formKey,
    );
  }

  @override
  List<Object?> get props => [
    id,
    idOrden,
    metodoPago,
    monto,
    referencia,
    entidadFinanciera,
    observaciones,
    responseMetodoPago,
    responseEntidadFinanciera,
    orden,
  ];
}
