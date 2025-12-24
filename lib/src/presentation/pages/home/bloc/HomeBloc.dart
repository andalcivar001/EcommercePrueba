import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthUseCases authUseCases;

  HomeBloc(this.authUseCases) : super(HomeState()) {
    on<InitHomeEvent>(_onInit);
    on<PageChangeHomeEvent>(_onPageChange);
    on<LogoutHomeEvent>(_onLogout);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(InitHomeEvent event, Emitter<HomeState> emit) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    if (authResponse != null) {
      print('HOMEBLOC USESR ${authResponse.user}');
      emit(state.copyWith(user: authResponse.user));
    }
  }

  Future<void> _onPageChange(
    PageChangeHomeEvent event,
    Emitter<HomeState> emit,
  ) async {}

  Future<void> _onLogout(LogoutHomeEvent event, Emitter<HomeState> emit) async {
    await authUseCases.logout.run();
  }
}
