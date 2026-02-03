import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientListBloc extends Bloc<ClientListEvent, ClientListState> {
  ClientUseCases clientUseCases;
  ClientListBloc(this.clientUseCases) : super(ClientListState()) {
    on<InitClientListEvent>(_onInit);
    on<BusquedaChangedClientListEvent>(_onBusquedaChanged);
    on<DeleteClientListEvent>(_onDelete);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitClientListEvent event,
    Emitter<ClientListState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));

    emit(state.copyWith(response: Loading(), formKey: formKey));

    final Resource response = await clientUseCases.getClients.run();
    List<Client> listaClient = [];
    if (response is Success) {
      listaClient = response.data as List<Client>;
    }
    emit(
      state.copyWith(
        response: response,
        listaClient: listaClient,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onBusquedaChanged(
    BusquedaChangedClientListEvent event,
    Emitter<ClientListState> emit,
  ) async {
    final filtrado = state.listaClient!
        .where(
          (x) =>
              x.nombre.toLowerCase().contains(event.busqueda.toLowerCase()) ||
              x.numeroIdentificacion.toLowerCase().contains(
                event.busqueda.toLowerCase(),
              ),
        )
        .toList();

    emit(
      state.copyWith(
        busqueda: event.busqueda,
        formKey: formKey,
        response: Success(filtrado),
      ),
    );
  }

  Future<void> _onDelete(
    DeleteClientListEvent event,
    Emitter<ClientListState> emit,
  ) async {
    emit(state.copyWith(responseDelete: Loading(), formKey: formKey));

    final Resource response = await clientUseCases.delete.run(event.id);

    emit(state.copyWith(responseDelete: response, formKey: formKey));
  }
}
