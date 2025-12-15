import 'package:ecommerce_prueba/src/domain/models/AuthResponse.dart';
import 'package:ecommerce_prueba/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthUseCases authUseCases;

  RegisterBloc(this.authUseCases) : super(RegisterState()) {
    on<InitRegisterEvent>(_onInit);
    on<ResetFormRegisterEvent>(_onResetForm);
    on<NameChangedRegisterEvent>(_onNameChanged);
    on<EmailChangedRegisterEvent>(_onEmailChanged);
    on<PasswordChangedRegisterEvent>(_onPasswordChanged);
    on<FechaNacimientoChangedRegisterEvent>(_onFechaNacimientoChanged);
    on<SubmittedRegisterEvent>(_onSubmitted);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.coypWith(formKey: formKey));
  }

  Future<void> _onResetForm(
    ResetFormRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    state.formKey?.currentState?.reset();
  }

  Future<void> _onNameChanged(
    NameChangedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    {
      emit(
        state.coypWith(
          nombre: BlocFormItem(
            value: event.name.value,
            error: event.name.value.isNotEmpty ? null : 'Ingrese el nombre',
          ),
          formKey: formKey,
        ),
      );
    }
  }

  Future<void> _onEmailChanged(
    EmailChangedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.coypWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isNotEmpty ? null : 'Ingrese el email',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onPasswordChanged(
    PasswordChangedRegisterEvent event,
    Emitter<RegisterState> emit,
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

  Future<void> _onFechaNacimientoChanged(
    FechaNacimientoChangedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.coypWith(
        fechaNacimiento: BlocFormItem(
          value: event.fechaNacimiento.value,
          error: event.fechaNacimiento.value.isNotEmpty
              ? null
              : 'Ingrese la fecha de nacimiento',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onSubmitted(
    SubmittedRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.coypWith(response: Loading(), formKey: formKey));

    Resource<AuthResponse> response = await authUseCases.register.ru(
      state.toUser(),
    );
    emit(state.coypWith(response: response, formKey: formKey));
  }
}
