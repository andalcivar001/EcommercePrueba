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
  final BlocFormItem nombre;
  const NameChangedRegisterEvent({required this.nombre});
  @override
  List<Object?> get props => [nombre];
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

class ConfirmPasswordChangedRegisterEvent extends RegisterEvent {
  final BlocFormItem confirmPassword;
  const ConfirmPasswordChangedRegisterEvent({required this.confirmPassword});
  @override
  List<Object?> get props => [confirmPassword];
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
