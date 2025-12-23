import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/users/UsersUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthUseCases authUseCases;
  UsersUseCases usersUseCases;

  ProfileBloc(this.authUseCases, this.usersUseCases) : super(ProfileState()) {
    on<InitProfileEvent>(_onInit);
    on<NombreChangedProfileEvent>(_onNombreChanged);
    on<TelefonoChangedProfileEvent>(_onTelefonoChanged);
    on<FechaNacimientoProfileEvent>(_onFechaNacimiento);
    on<PickImageProfileEvent>(_onPickImage);
    on<TakePhotoProfileEvent>(_onTakePhoto);
    on<FormSubmittedProfileEvent>(_onFormSubmitted);
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
      final String fecha = user.fechaNacimiento = user.fechaNacimiento!
          .substring(0, 10);
      user.fechaNacimiento = fecha;
      // user.image =
      //     'https://firebasestorage.googleapis.com/v0/b/ecommerce-imagenes-3b10a.firebasestorage.app/o/user.png?alt=media&token=dee71b6a-bdd4-45ed-96a8-fe4155fa5c1c';
      emit(
        state.copyWith(
          user: user,
          id: user.id,
          nombre: BlocFormItem(value: user.nombre),
          telefono: BlocFormItem(value: user.telefono ?? ''),
          fechaNacimiento: BlocFormItem(value: user.fechaNacimiento ?? ''),
          imagenUrl: user.imagen,
          formKey: formKey,
        ),
      );
    }
  }

  Future<void> _onNombreChanged(
    NombreChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        nombre: BlocFormItem(
          value: event.nombre.value,
          error: event.nombre.value.isNotEmpty ? null : 'Ingrese el nombre',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onTelefonoChanged(
    TelefonoChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        telefono: BlocFormItem(
          value: event.telefono.value,
          error: event.telefono.value.isNotEmpty ? null : 'Ingrese el telefono',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onFechaNacimiento(
    FechaNacimientoProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        fechaNacimiento: BlocFormItem(
          value: event.fechaNacimiento.value,
          error: event.fechaNacimiento.value.isNotEmpty
              ? null
              : 'Ingrese fecha de nacimiento',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onPickImage(
    PickImageProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(image: File(image.path), formKey: formKey));
    }
  }

  Future<void> _onTakePhoto(
    TakePhotoProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(state.copyWith(image: File(image.path), formKey: formKey));
    }
  }

  Future<void> _onFormSubmitted(
    FormSubmittedProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    print('entro al event submmit');
    emit(state.copyWith(response: Loading(), formKey: formKey));
    final response = await usersUseCases.update.run(
      state.id,
      state.toUser(),
      state.imagen,
    );
    print('RESPONSE $response');
    emit(state.copyWith(response: response, formKey: formKey));
  }
}
