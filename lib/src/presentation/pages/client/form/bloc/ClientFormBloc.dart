import 'package:ecommerce_prueba/src/domain/models/City.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/Province.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientFormBloc extends Bloc<ClientFormEvent, ClientFormState> {
  ClientUseCases clientUseCases;
  ClientFormBloc(this.clientUseCases) : super(ClientFormState()) {
    on<InitClientFormEvent>(_onInit);
    on<NombreChangedClientFormEvent>(_onNombreChanged);
    on<TipoIdentificacionChangedClientFormEvent>(_onTipoIdentificacionChanged);
    on<NumeroIdentificacionChangedClientFormEvent>(
      _onNumeroIdentificacionChanged,
    );
    on<EmailChangedClientFormEvent>(_onEmailChanged);
    on<DireccionChangedClientFormEvent>(_onDireccionChanged);
    on<TelefonoChangedClientFormEvent>(_onTelefonoChanged);
    on<ProvinciaChangedClientFormEvent>(_onProvinciaChanged);
    on<CiudadChangedClientFormEvent>(_onCiudadChanged);
    on<LatitudChangedClientFormEvent>(_onLatitudChanged);
    on<LongitudChangedClientFormEvent>(_onLongitudChanged);
    on<SubmittedClientFormEvent>(_onSubmitted);
    on<PickLocationClientFormEvent>(_onPickLocation);
    on<EstadoChangedClientFormEvent>(_onEstadoChanged);
    on<ResetFormClientFormEvent>(_onResetForm);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(
      state.copyWith(
        responseProvinces: Loading(),
        responseCities: Loading(),
        responseCliente: event.id.isNotEmpty
            ? Loading()
            : state.responseCliente,
        formKey: formKey,
      ),
    );

    // 2) Pide provincias + ciudades en paralelo
    final results = await Future.wait<Resource>([
      clientUseCases.getProvinces.run(),
      clientUseCases.getCities.run(),
    ]);

    final responseProvincias = results[0];
    final responseCiuidades = results[1];

    final List<Province> listaProvincia = responseProvincias is Success
        ? (responseProvincias.data as List<Province>)
        : <Province>[];

    final List<City> listaCiudades = responseCiuidades is Success
        ? (responseCiuidades.data as List<City>)
        : <City>[];

    // 3) Si es edición, trae el cliente
    Resource? responseCliente;
    Client? cliente;

    if (event.id.isNotEmpty) {
      responseCliente = await clientUseCases.getClientById.run(event.id);
      if (responseCliente is Success) {
        cliente = responseCliente as Client;
      }
    }

    // 4) Calcula valores finales
    final String nombre = cliente?.nombre ?? '';
    final String tipoIdentificacion = cliente?.tipoIdentificacion ?? '';
    final String numeroIdentificacion = cliente?.numeroIdentificacion ?? '';
    final String email = cliente?.email ?? '';
    final String? direccion = cliente?.direccion;
    final String? telefono = cliente?.telefono;
    final String idProvincia = cliente?.idProvincia ?? '';
    final String? idCiudad = cliente?.idCiudad;

    final Province? provincia = idProvincia.isNotEmpty
        ? listaProvincia.firstWhere((x) => x.id == idProvincia)
        : null;

    final List<City> ciudadesFiltradas =
        idProvincia.isNotEmpty && provincia != null
        ? listaCiudades
              .where((x) => x.codigoProvincia == provincia.codigoProvincia)
              .toList()
        : <City>[];
  }

  Future<void> _onNombreChanged(
    NombreChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onTipoIdentificacionChanged(
    TipoIdentificacionChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onNumeroIdentificacionChanged(
    NumeroIdentificacionChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onEmailChanged(
    EmailChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onDireccionChanged(
    DireccionChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onTelefonoChanged(
    TelefonoChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onProvinciaChanged(
    ProvinciaChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onCiudadChanged(
    CiudadChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onLatitudChanged(
    LatitudChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}
  Future<void> _onLongitudChanged(
    LongitudChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onSubmitted(
    SubmittedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onPickLocation(
    PickLocationClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onEstadoChanged(
    EstadoChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

  Future<void> _onResetForm(
    ResetFormClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}
}
