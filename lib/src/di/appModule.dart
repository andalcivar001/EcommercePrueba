import 'package:ecommerce_prueba/src/data/datasource/local/SharedPref.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/AuthService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/CategoryService.dart';
import 'package:ecommerce_prueba/src/data/datasource/remote/services/UserService.dart';
import 'package:ecommerce_prueba/src/data/repository/AuthRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/data/repository/CategoryRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/data/repository/UserRepositoryImpl.dart';
import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/repository/AuthRepository.dart';
import 'package:ecommerce_prueba/src/domain/repository/CategoryRepository.dart';
import 'package:ecommerce_prueba/src/domain/repository/UserRepository.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CreateCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/GetCategoriesUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/UpdateCategoryUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/LoginUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/LogoutUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/RegisterUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/SaveUserSessionUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/users/UpdateUsersUseCase.dart';
import 'package:ecommerce_prueba/src/domain/useCases/users/UsersUseCases.dart';
import 'package:injectable/injectable.dart';

@module
abstract class Appmodule {
  @injectable
  SharedPref get sharedPref => SharedPref();

  @injectable
  Future<String> get token async {
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

  @injectable
  UserService get userService => UserService(token);

  @injectable
  CategoryService get categoryService => CategoryService(token);

  /******** REPOSITORIOS *********** */ ////
  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(authService, sharedPref);

  @injectable
  UserRepository get userRepository => UserRepositoryImpl(userService);

  @injectable
  CategoryRepository get categoryRepository =>
      CategoryRepositoryImpl(categoryService);

  /********* USECASE *******/
  ///
  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    getUserSession: GetUserSessionUseCase(authRepository),
    saveUserSession: SaveUserSessionUseCase(authRepository),
    logout: LogoutUseCase(authRepository),
  );

  @injectable
  UsersUseCases get userUseCase =>
      UsersUseCases(update: UpdateUsersUseCase(userRepository));

  @injectable
  CategoryUseCases get categoryUseCases => CategoryUseCases(
    getCategories: GetCategoriesUseCase(categoryRepository),
    create: CreateCategoryUseCase(categoryRepository),
    update: UpdateCategoryUseCase(categoryRepository),
  );
}
