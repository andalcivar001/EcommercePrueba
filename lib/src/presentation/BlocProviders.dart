import 'package:ecommerce_prueba/injection.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/users/UsersUseCases.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(
    create: (context) =>
        LoginBloc(locator<AuthUseCases>())..add(InitLoginEvent()),
  ),

  BlocProvider<RegisterBloc>(
    create: (context) =>
        RegisterBloc(locator<AuthUseCases>())..add(InitRegisterEvent()),
  ),

  BlocProvider<HomeBloc>(
    create: (context) =>
        // HomeBloc(locator<AuthUseCases>())..add(InitHomeEvent()),
        HomeBloc(locator<AuthUseCases>()),
  ),
  BlocProvider<ProfileBloc>(
    create: (context) =>
        ProfileBloc(locator<AuthUseCases>(), locator<UsersUseCases>())
          ..add(InitProfileEvent()),
  ),

  BlocProvider<CategoryListBloc>(
    create: (context) =>
        CategoryListBloc(locator<CategoryUseCases>())
          ..add(InitCategoryListEvent()),
  ),
];
