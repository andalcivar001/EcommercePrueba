import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthUseCases authUseCases;

  LoginBloc(this.authUseCases) : super(LoginState()) {
    on<InitLoginEvent>(_onInit);
    on<EmailChangedLoginEvent>(_onEmailChanged);
    on<PasswordChangedLoginEvent>(_onPasswordChanged);
    on<SubmittedLoginEvent>(_onSubmitted);
    on<FormResetLoginEvent>(_onFormReset);
    on<SaveUserSessionLoginEvent>(_onSaveUserSession);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(InitLoginEvent event, Emitter<LoginState> emit) async {
    AuthResponse? authResponse = await authUseCases.getUserSession.run();
    emit(state.coypWith(formKey: formKey));
    if (authResponse != null) {
      emit(state.coypWith(response: Success(authResponse), formKey: formKey));
    }
  }

  Future<void> _onEmailChanged(
    EmailChangedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.coypWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isNotEmpty ? null : 'Ingrese un email',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onPasswordChanged(
    PasswordChangedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.coypWith(
        password: BlocFormItem(
          value: event.password.value,
          error: event.password.value.isNotEmpty
              ? null
              : 'Ingrese la contraseña',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onSubmitted(
    SubmittedLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.coypWith(response: Loading(), formKey: formKey));
    Resource<AuthResponse> response = await authUseCases.login.run(
      state.email.value,
      state.password.value,
    );

    emit(state.coypWith(response: response, formKey: formKey));
  }

  Future<void> _onFormReset(
    FormResetLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    state.formKey?.currentState?.reset();
  }

  Future<void> _onSaveUserSession(
    SaveUserSessionLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    await authUseCases.saveUserSession.run(event.authResponse);
  }
}
