import 'package:collection/collection.dart';
import 'package:ecommerce_prueba/src/domain/models/City.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/models/Province.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
        cliente = responseCliente.data as Client;
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

    final String codigoProvincia = provincia?.codigoProvincia ?? '';

    emit(
      state.copyWith(
        listaProvincias: listaProvincia,
        listaCiudades: listaCiudades,
        responseProvinces: responseProvincias,
        responseCities: cliente?.id != null
            ? Success(ciudadesFiltradas)
            : Success(listaCiudades),
        responseCliente: responseCliente,
        id: event.id,
        nombre: BlocFormItem(
          value: nombre,
          error: nombre.isNotEmpty ? null : 'Ingrese el nombre',
        ),
        tipoIdentificacion: tipoIdentificacion,
        numeroIdentificacion: BlocFormItem(
          value: numeroIdentificacion,
          error: numeroIdentificacion.isNotEmpty
              ? null
              : 'Ingrese numero de identificacion',
        ),
        email: BlocFormItem(
          value: email,
          error: email.isNotEmpty ? null : 'Ingrese el email',
        ),
        direccion: direccion,
        telefono: telefono,
        idProvincia: idProvincia,
        idCiudad: idCiudad,
        latitud: cliente?.latitud,
        longitud: cliente?.longitud,
        codigoProvincia: codigoProvincia,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onNombreChanged(
    NombreChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(
      state.copyWith(
        nombre: BlocFormItem(
          value: event.nombre.value,
          error: event.nombre.value.isNotEmpty ? null : 'Ingrese el nombre',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onTipoIdentificacionChanged(
    TipoIdentificacionChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(
      state.copyWith(
        tipoIdentificacion: event.tipoIdentificacion,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onNumeroIdentificacionChanged(
    NumeroIdentificacionChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(
      state.copyWith(
        numeroIdentificacion: BlocFormItem(
          value: event.numeroIdentificacion.value,
          error: event.numeroIdentificacion.value.isNotEmpty
              ? null
              : 'Ingrese el # de identificación',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onEmailChanged(
    EmailChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isNotEmpty ? null : 'Ingrese el email',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onDireccionChanged(
    DireccionChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(state.copyWith(direccion: event.direccion, formKey: formKey));
  }

  Future<void> _onTelefonoChanged(
    TelefonoChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(state.copyWith(telefono: event.telefono, formKey: formKey));
  }

  Future<void> _onProvinciaChanged(
    ProvinciaChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    final provincia = state.listaProvincias.firstWhere(
      (x) => x.id == event.idProvincia,
    );
    emit(
      state.copyWith(
        idProvincia: event.idProvincia,
        codigoProvincia: provincia.codigoProvincia,
        idCiudad: null,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onCiudadChanged(
    CiudadChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(state.copyWith(idCiudad: event.idCiudad, formKey: formKey));
  }

  Future<void> _onPickLocation(
    PickLocationClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppToast.error('Servicio de localización no esta habilitado');
      return;
    }

    // verifico permisos
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppToast.error('Permiso de ubicación denegado');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      AppToast.error(
        'Permiso denegado permanentemente, Por favor habilitarlo desde ajustes',
      );
      return;
    }

    emit(state.copyWith(loading: true));

    final position = await Geolocator.getCurrentPosition();

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Province? provincia;
    City? ciudad;
    String? direccion;
    if (placemarks.isNotEmpty) {
      final Placemark placemark = placemarks[0];
      provincia = state.listaProvincias.firstWhereOrNull(
        (x) => x.nombre == placemark.administrativeArea,
      );

      ciudad = state.listaCiudades.firstWhereOrNull(
        (x) => x.nombre == placemark.subAdministrativeArea,
      );

      direccion = placemark.street;
    }
    emit(
      state.copyWith(
        idProvincia: provincia?.id ?? state.idProvincia,
        idCiudad: ciudad?.id ?? state.idCiudad,
        codigoProvincia: provincia?.codigoProvincia ?? state.codigoProvincia,
        direccion: direccion ?? state.direccion,
        latitud: position.latitude,
        longitud: position.longitude,
        loading: false,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onEstadoChanged(
    EstadoChangedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(state.copyWith(isActive: event.isActive, formKey: formKey));
  }

  Future<void> _onSubmitted(
    SubmittedClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(state.copyWith(response: Loading(), formKey: formKey));

    final Client client = Client(
      id: state.id,
      nombre: state.nombre.value,
      tipoIdentificacion: state.tipoIdentificacion,
      numeroIdentificacion: state.numeroIdentificacion.value,
      email: state.email.value,
      idProvincia: state.idProvincia,
      idCiudad: state.idCiudad ?? '',
      direccion: state.direccion,
      telefono: state.telefono,
      latitud: state.latitud,
      longitud: state.longitud,
    );

    if (state.id.isEmpty) {
      final response = await clientUseCases.create.run(client);
      emit(state.copyWith(response: response, formKey: formKey));
    } else {
      final response = await clientUseCases.update.run(client, state.id);
      emit(state.copyWith(response: response, formKey: formKey));
    }
  }

  Future<void> _onResetForm(
    ResetFormClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {
    emit(
      ClientFormState.initial().copyWith(
        listaProvincias: state.listaProvincias,
        listaCiudades: state.listaCiudades,
      ),
    );
  }
}
