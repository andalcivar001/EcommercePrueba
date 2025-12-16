import 'package:ecommerce_prueba/src/data/datasource/local/SharedPref.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/AuthService.dart';
import 'package:ecommerce_prueba/src/data/repository/AuthRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/repository/AuthRepository.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/SaveUserSessionUseCase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class Appmodule {
  @injectable
  SharedPref get sharedPref => SharedPref();

  @injectable
  Future<String> get getToken async {
    String token = "";
    final userSession = await sharedPref.read('user');
    if (userSession != null) {
      //convertir el objeto dinamico a una clase
      AuthResponse authResponse = AuthResponse.fromJson(userSession);
      token = authResponse.token;
    }
    return token;
  }

  /******* SERVICIOS *****/
  @injectable
  AuthService get authService => AuthService();

  /******** REPOSITORIOS *********** */ ////
  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(authService, sharedPref);

  /********* USECASE *******/
  ///
  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    getUser: GetUserSessionUseCase(authRepository),
    saveUser: SaveUserSessionUseCase(authRepository),
    logout: LogoutUseCase(authRepository),
  );
}
