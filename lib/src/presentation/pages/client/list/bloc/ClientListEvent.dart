import 'package:equatable/equatable.dart';

abstract class ClientListEvent extends Equatable {
  const ClientListEvent();
  @override
  List<Object?> get props => [];
}

class InitClientListEvent extends ClientListEvent {
  const InitClientListEvent();
}

class BusquedaChangedClientListEvent extends ClientListEvent {
  final String busqueda;
  const BusquedaChangedClientListEvent({required this.busqueda});
  @override
  // TODO: implement props
  List<Object?> get props => [busqueda];
}

class DeleteClientListEvent extends ClientListEvent {
  final String id;
  const DeleteClientListEvent({required this.id});
}
