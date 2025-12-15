import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object?> get props => [];
}

class InitRegisterEvent extends RegisterEvent {
  const InitRegisterEvent();
}

class ResetFormRegisterEvent extends RegisterEvent {
  const ResetFormRegisterEvent();
}

class NameChangedRegisterEvent extends RegisterEvent {
  final BlocFormItem name;
  const NameChangedRegisterEvent({required this.name});
  @override
  List<Object?> get props => [name];
}

class EmailChangedRegisterEvent extends RegisterEvent {
  final BlocFormItem email;
  const EmailChangedRegisterEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

class PasswordChangedRegisterEvent extends RegisterEvent {
  final BlocFormItem password;
  const PasswordChangedRegisterEvent({required this.password});
  @override
  List<Object?> get props => [password];
}

class FechaNacimientoChangedRegisterEvent extends RegisterEvent {
  final BlocFormItem fechaNacimiento;
  const FechaNacimientoChangedRegisterEvent({required this.fechaNacimiento});
  @override
  List<Object?> get props => [fechaNacimiento];
}

class SubmittedRegisterEvent extends RegisterEvent {
  const SubmittedRegisterEvent();
}
