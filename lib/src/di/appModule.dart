import 'package:ecommerce_prueba/src/data/datasource/remote/services/AuthService.dart';
import 'package:ecommerce_prueba/src/data/repository/AuthRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/domain/repository/AuthRepository.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class Appmodule {
  /******* SERVICIOS *****/
  ///
  @injectable
  AuthService get authService => AuthService();

  /******** REPOSITORIOS *********** */ ////
  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService);

  /********* USECASE *******/
  ///
  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
  );
}
