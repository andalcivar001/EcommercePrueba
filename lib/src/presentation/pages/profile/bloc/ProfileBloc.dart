import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthUseCases authUseCases;

  ProfileBloc(this.authUseCases) : super(ProfileState()) {
    on<InitProfileEvent>(_onInit);
    // on<NombreChangedProfileEvent>(_onNombreChanged);
    // on<TelefonoChangedProfileEvent>(_onTelefonoChanged);
    // on<FechaNacimientoProfileEvent>(_onFechaNacimiento);
    // on<FormSubmittedProfileEvent>(_onFormSubmitted);
    // on<ResetFormProfileEvent>(_onResetForm);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    if (authResponse != null) {
      final User user = authResponse.user;
      emit(
        state.copyWith(
          id: user.id,
          nombre: BlocFormItem(value: user.nombre),
          telefono: BlocFormItem(value: user.telefono ?? ''),
          fechaNacimiento: BlocFormItem(value: user.fechaNacimiento ?? ''),
          formKey: formKey,
        ),
      );
    }
  }
}
