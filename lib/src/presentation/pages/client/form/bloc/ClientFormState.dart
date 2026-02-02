import 'package:ecommerce_prueba/src/domain/models/City.dart';
import 'package:ecommerce_prueba/src/domain/models/Province.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ClientFormState extends Equatable {
  final String id;
  final BlocFormItem nombre;
  final String tipoIdentificacion;
  final BlocFormItem numeroIdentificacion;
  final BlocFormItem email;
  final String? direccion;
  final String? telefono;
  final String idProvincia;
  final String? idCiudad;
  final double? latitud;
  final double? longitud;
  final List<Province> listaProvincias;
  final List<City> listaCiudades;
  final Resource? response;
  final GlobalKey<FormState>? formKey;
  final Resource? responseProvinces;
  final Resource? responseCities;
  final Resource? responseCliente;
  final bool isActive;
  final String codigoProvincia;

  ClientFormState({
    this.id = '',
    this.nombre = const BlocFormItem(error: 'Ingrese el nombre'),
    this.tipoIdentificacion = '',
    this.numeroIdentificacion = const BlocFormItem(
      error: 'Ingrese el numero de identificacion',
    ),
    this.email = const BlocFormItem(error: 'Ingrese el email'),
    this.direccion,
    this.telefono,
    this.idProvincia = '',
    this.idCiudad,
    this.latitud,
    this.longitud,
    this.listaProvincias = const [],
    this.listaCiudades = const [],
    this.response,
    this.formKey,
    this.responseProvinces,
    this.responseCities,
    this.isActive = true,
    this.responseCliente,
    this.codigoProvincia = '',
  });

  ClientFormState copyWith({
    String? id,
    BlocFormItem? nombre,
    String? tipoIdentificacion,
    BlocFormItem? numeroIdentificacion,
    BlocFormItem? email,
    String? direccion,
    String? telefono,
    String? idProvincia,
    String? idCiudad,
    double? latitud,
    double? longitud,
    List<Province>? listaProvincias,
    List<City>? listaCiudades,
    Resource? response,
    GlobalKey<FormState>? formKey,
    Resource? responseProvinces,
    Resource? responseCities,
    bool? isActive,
    Resource? responseCliente,
    String? codigoProvincia,
  }) {
    return ClientFormState(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipoIdentificacion: tipoIdentificacion ?? this.tipoIdentificacion,
      numeroIdentificacion: numeroIdentificacion ?? this.numeroIdentificacion,
      email: email ?? this.email,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      idProvincia: idProvincia ?? this.idProvincia,
      idCiudad: idCiudad ?? this.idCiudad,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      listaProvincias: listaProvincias ?? this.listaProvincias,
      listaCiudades: listaCiudades ?? this.listaCiudades,
      response: response,
      formKey: formKey,
      responseProvinces: responseProvinces ?? this.responseProvinces,
      responseCities: responseCities ?? this.responseCities,
      isActive: isActive ?? this.isActive,
      responseCliente: responseCliente ?? this.responseCliente,
      codigoProvincia: codigoProvincia ?? this.codigoProvincia,
    );
  }

  factory ClientFormState.initial() => ClientFormState(
    formKey: GlobalKey<FormState>(),
    nombre: BlocFormItem(value: ''),
    tipoIdentificacion: '',
    numeroIdentificacion: BlocFormItem(value: ''),
    email: BlocFormItem(value: ''),
    direccion: null,
    telefono: null,
    idProvincia: '',
    idCiudad: null,
    latitud: null,
    longitud: null,
    listaProvincias: [],
    listaCiudades: [],
  );

  @override
  List<Object?> get props => [
    id,
    nombre,
    tipoIdentificacion,
    numeroIdentificacion,
    email,
    direccion,
    telefono,
    idProvincia,
    idCiudad,
    latitud,
    longitud,
    listaProvincias,
    listaCiudades,
    response,
    responseProvinces,
    responseCities,
    isActive,
    responseCliente,
    codigoProvincia,
  ];
}
