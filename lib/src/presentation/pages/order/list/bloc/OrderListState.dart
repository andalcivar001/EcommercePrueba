import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderListState extends Equatable {
  final String? cliente;
  final DateTime? fechaDesde;
  final DateTime? fechaHasta;
  final GlobalKey<FormState>? formKey;
  final Resource? response;
  final Resource? responseCliente;
  final Client? clienteSeleccionado;

  OrderListState({
    this.response,
    this.formKey,
    this.cliente,
    this.fechaDesde,
    this.fechaHasta,
    this.responseCliente,
    this.clienteSeleccionado,
  });

  OrderListState copyWith({
    String? cliente,
    DateTime? fechaDesde,
    DateTime? fechaHasta,
    GlobalKey<FormState>? formKey,
    Resource? response,
    Resource? responseCliente,
    Client? clienteSeleccionado,
  }) {
    return OrderListState(
      cliente: cliente ?? this.cliente,
      fechaDesde: fechaDesde ?? this.fechaDesde,
      fechaHasta: fechaHasta ?? this.fechaHasta,
      response: response,
      formKey: formKey,
      responseCliente: response ?? this.responseCliente,
      clienteSeleccionado: clienteSeleccionado ?? this.clienteSeleccionado,
    );
  }

  @override
  List<Object?> get props => [
    cliente,
    fechaDesde,
    fechaHasta,
    response,
    responseCliente,
    clienteSeleccionado,
  ];
}
