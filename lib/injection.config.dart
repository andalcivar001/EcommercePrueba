// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ecommerce_prueba/src/data/datasource/local/SharedPref.dart'
    as _i195;
import 'package:ecommerce_prueba/src/data/datasource/remote/services/AuthService.dart'
    as _i1032;
import 'package:ecommerce_prueba/src/data/datasource/remote/services/CategoryService.dart'
    as _i858;
import 'package:ecommerce_prueba/src/data/datasource/remote/services/ClientService.dart'
    as _i218;
import 'package:ecommerce_prueba/src/data/datasource/remote/services/ProductService.dart'
    as _i511;
import 'package:ecommerce_prueba/src/data/datasource/remote/services/SubCategoryService.dart'
    as _i879;
import 'package:ecommerce_prueba/src/data/datasource/remote/services/UserService.dart'
    as _i1052;
import 'package:ecommerce_prueba/src/di/appModule.dart' as _i319;
import 'package:ecommerce_prueba/src/domain/repository/AuthRepository.dart'
    as _i732;
import 'package:ecommerce_prueba/src/domain/repository/CategoryRepository.dart'
    as _i596;
import 'package:ecommerce_prueba/src/domain/repository/ClientRepository.dart'
    as _i473;
import 'package:ecommerce_prueba/src/domain/repository/ProductRepository.dart'
    as _i199;
import 'package:ecommerce_prueba/src/domain/repository/SubCategoryRepository.dart'
    as _i888;
import 'package:ecommerce_prueba/src/domain/repository/UserRepository.dart'
    as _i584;
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart'
    as _i203;
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart'
    as _i138;
import 'package:ecommerce_prueba/src/domain/useCases/Client/ClientUseCases.dart'
    as _i738;
import 'package:ecommerce_prueba/src/domain/useCases/Product/ProductUseCases.dart'
    as _i92;
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/SubCategoryUseCases.dart'
    as _i807;
import 'package:ecommerce_prueba/src/domain/useCases/users/UsersUseCases.dart'
    as _i713;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appmodule = _$Appmodule();
    gh.factory<_i195.SharedPref>(() => appmodule.sharedPref);
    gh.factoryAsync<String>(() => appmodule.token);
    gh.factory<_i1032.AuthService>(() => appmodule.authService);
    gh.factory<_i1052.UserService>(() => appmodule.userService);
    gh.factory<_i858.CategoryService>(() => appmodule.categoryService);
    gh.factory<_i879.SubCategoryService>(() => appmodule.subCategoryService);
    gh.factory<_i511.ProductService>(() => appmodule.productService);
    gh.factory<_i218.ClienteService>(() => appmodule.clientService);
    gh.factory<_i732.AuthRepository>(() => appmodule.authRepository);
    gh.factory<_i584.UserRepository>(() => appmodule.userRepository);
    gh.factory<_i596.CategoryRepository>(() => appmodule.categoryRepository);
    gh.factory<_i888.SubCategoryRepository>(
      () => appmodule.subCategoryRepository,
    );
    gh.factory<_i199.ProductRepository>(() => appmodule.productRepository);
    gh.factory<_i473.ClientRepository>(() => appmodule.clientRepository);
    gh.factory<_i203.AuthUseCases>(() => appmodule.authUseCases);
    gh.factory<_i713.UsersUseCases>(() => appmodule.userUseCase);
    gh.factory<_i138.CategoryUseCases>(() => appmodule.categoryUseCases);
    gh.factory<_i807.SubCategoryUseCases>(() => appmodule.subCategoryUseCases);
    gh.factory<_i92.ProductUseCases>(() => appmodule.productUseCases);
    gh.factory<_i738.ClientUseCases>(() => appmodule.clientUseCases);
    return this;
  }
}

class _$Appmodule extends _i319.Appmodule {}
