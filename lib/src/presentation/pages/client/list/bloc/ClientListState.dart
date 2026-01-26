import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ClientListState extends Equatable {
  final String busqueda;
  final Resource? response;
  final Resource? responseDelete;
  final List<Client>? listaClient;
  final GlobalKey<FormState>? formKey;

  ClientListState({
    this.busqueda = '',
    this.responseDelete,
    this.response,
    this.formKey,
    this.listaClient,
  });

  ClientListState copyWith({
    String? busqueda,
    Resource? response,
    Resource? responseDelete,
    List<Client>? listaClient,
    GlobalKey<FormState>? formKey,
  }) {
    return ClientListState(
      busqueda: busqueda ?? this.busqueda,
      responseDelete: responseDelete,
      listaClient: listaClient ?? this.listaClient,
      response: response,
      formKey: formKey,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [busqueda, response, responseDelete, listaClient];
}
