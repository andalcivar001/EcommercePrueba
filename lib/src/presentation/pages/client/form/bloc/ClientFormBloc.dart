import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientFormBloc extends Bloc<ClientFormEvent, ClientFormState> {
  ClientFormBloc() : super(ClientFormState()) {
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
  Future<void> _onInit(
    InitClientFormEvent event,
    Emitter<ClientFormState> emit,
  ) async {}

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
