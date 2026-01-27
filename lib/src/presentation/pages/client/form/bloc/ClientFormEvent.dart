import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';

abstract class ClientFormEvent extends Equatable {
  const ClientFormEvent();
  @override
  List<Object?> get props => [];
}

class InitClientFormEvent extends ClientFormEvent {
  final String? id;
  const InitClientFormEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class NombreChangedClientFormEvent extends ClientFormEvent {
  final BlocFormItem nombre;
  const NombreChangedClientFormEvent({required this.nombre});
  @override
  List<Object?> get props => [nombre];
}

class TipoIdentificacionChangedClientFormEvent extends ClientFormEvent {
  final String tipoIdentificacion;
  const TipoIdentificacionChangedClientFormEvent({
    required this.tipoIdentificacion,
  });
  @override
  List<Object?> get props => [tipoIdentificacion];
}

class NumeroIdentificacionChangedClientFormEvent extends ClientFormEvent {
  final BlocFormItem numeroIdentificacion;
  const NumeroIdentificacionChangedClientFormEvent({
    required this.numeroIdentificacion,
  });
  @override
  List<Object?> get props => [numeroIdentificacion];
}

class EmailChangedClientFormEvent extends ClientFormEvent {
  final BlocFormItem email;
  const EmailChangedClientFormEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

class DireccionChangedClientFormEvent extends ClientFormEvent {
  final String direccion;
  const DireccionChangedClientFormEvent({required this.direccion});
  @override
  List<Object?> get props => [direccion];
}

class TelefonoChangedClientFormEvent extends ClientFormEvent {
  final int telefono;
  const TelefonoChangedClientFormEvent({required this.telefono});
  @override
  List<Object?> get props => [telefono];
}

class ProvinciaChangedClientFormEvent extends ClientFormEvent {
  final String idProvincia;
  const ProvinciaChangedClientFormEvent({required this.idProvincia});
  @override
  List<Object?> get props => [idProvincia];
}

class CiudadChangedClientFormEvent extends ClientFormEvent {
  final String idCiudad;
  const CiudadChangedClientFormEvent({required this.idCiudad});
  @override
  List<Object?> get props => [idCiudad];
}

class LatitudChangedClientFormEvent extends ClientFormEvent {
  final double latitud;
  const LatitudChangedClientFormEvent({required this.latitud});
  @override
  List<Object?> get props => [latitud];
}

class LongitudChangedClientFormEvent extends ClientFormEvent {
  final double longitud;
  const LongitudChangedClientFormEvent({required this.longitud});
  @override
  List<Object?> get props => [longitud];
}

class SubmittedClientFormEvent extends ClientFormEvent {
  const SubmittedClientFormEvent();
}

class PickLocationClientFormEvent extends ClientFormEvent {
  const PickLocationClientFormEvent();
}

class ResetFormClientFormEvent extends ClientFormEvent {
  const ResetFormClientFormEvent();
}

class EstadoChangedClientFormEvent extends ClientFormEvent {
  final bool isActive;
  const EstadoChangedClientFormEvent({required this.isActive});
  @override
  List<Object?> get props => [isActive];
}
