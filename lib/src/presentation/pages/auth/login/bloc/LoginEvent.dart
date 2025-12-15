import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class InitLoginEvent extends LoginEvent {
  const InitLoginEvent();
}

class FormResetLoginEvent extends LoginEvent {
  const FormResetLoginEvent();
}

class EmailChangedLoginEvent extends LoginEvent {
  final BlocFormItem email;
  const EmailChangedLoginEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

class PasswordChangedLoginEvent extends LoginEvent {
  final BlocFormItem password;
  const PasswordChangedLoginEvent({required this.password});
  @override
  List<Object?> get props => [password];
}

class SubmittedLoginEvent extends LoginEvent {
  const SubmittedLoginEvent();
}
