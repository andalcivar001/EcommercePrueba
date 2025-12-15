import 'package:ecommerce_prueba/injection.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
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
];
