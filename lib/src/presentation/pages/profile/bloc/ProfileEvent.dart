import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitProfileEvent extends ProfileEvent {
  final User? user;

  const InitProfileEvent({this.user});
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class NombreChangedProfileEvent extends ProfileEvent {
  final BlocFormItem nombre;
  const NombreChangedProfileEvent({required this.nombre});
  @override
  List<Object?> get props => [nombre];
}

class TelefonoChangedProfileEvent extends ProfileEvent {
  final BlocFormItem telefono;
  const TelefonoChangedProfileEvent({required this.telefono});

  @override
  List<Object?> get props => [telefono];
}

class FechaNacimientoProfileEvent extends ProfileEvent {
  final BlocFormItem fechaNacimiento;
  const FechaNacimientoProfileEvent({required this.fechaNacimiento});

  @override
  List<Object?> get props => [fechaNacimiento];
}

class PickImageProfileEvent extends ProfileEvent {
  const PickImageProfileEvent();
}

class TakePhotoProfileEvent extends ProfileEvent {
  const TakePhotoProfileEvent();
}

class FormSubmittedProfileEvent extends ProfileEvent {
  const FormSubmittedProfileEvent();
}

class ResetFormProfileEvent extends ProfileEvent {
  const ResetFormProfileEvent();
}
