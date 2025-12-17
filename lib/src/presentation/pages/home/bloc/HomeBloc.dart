import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/home/bloc/HomeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthUseCases authUseCases;

  HomeBloc(this.authUseCases) : super(HomeState()) {
    on<PageChangeHomeEvent>(_onPageChange);
    on<LogoutHomeEvent>(_onLogout);
  }

  Future<void> _onPageChange(
    PageChangeHomeEvent event,
    Emitter<HomeState> emit,
  ) async {}

  Future<void> _onLogout(LogoutHomeEvent event, Emitter<HomeState> emit) async {
    await authUseCases.logout.run();
  }
}
