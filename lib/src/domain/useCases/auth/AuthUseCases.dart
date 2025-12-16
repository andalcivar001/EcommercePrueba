import 'package:ecommerce_prueba/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/SaveUserSessionUseCase.dart';

class AuthUseCases {
  LoginUseCase login;
  RegisterUseCase register;
  GetUserSessionUseCase getUser;
  SaveUserSessionUseCase saveUser;
  LogoutUseCase logout;
  AuthUseCases({
    required this.login,
    required this.register,
    required this.getUser,
    required this.saveUser,
    required this.logout,
  });
}
