import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/login/bloc/LoginState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefualtButton.dart';
import 'package:flutter/material.dart';

class LoginContent extends StatelessWidget {
  final LoginBloc? _bloc;
  final LoginState _state;

  const LoginContent(this._bloc, this._state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _state.formKey,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🔒 Icono
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3C72).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        size: 48,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 📝 Título
                  const Text(
                    'Bienvenido',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Inicia sesión para continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  // 📧 Email
                  _textEmail(),
                  const SizedBox(height: 16),

                  // 🔑 Password
                  _textPassword(),

                  const SizedBox(height: 28),

                  // 🔘 Botón Entrar
                  _buttonEntrar(),

                  const SizedBox(height: 14),

                  // 🆕 Crear cuenta
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Crear cuenta',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🎨 Decoración reusable

  Widget _textEmail() {
    return DefaultTextField(
      label: 'Correo electronico',
      icon: Icons.email_outlined,
      textInputType: TextInputType.emailAddress,

      onChanged: (text) {
        _bloc?.add(EmailChangedLoginEvent(email: BlocFormItem(value: text)));
      },
      validator: (value) {
        return _state.email.error;
      },
    );
  }

  Widget _textPassword() {
    return DefaultTextField(
      label: 'Contraseña',
      icon: Icons.lock_outline,
      validator: (value) {
        return _state.password.error;
      },
      obscureText: true,
      onChanged: (text) {
        _bloc?.add(
          PasswordChangedLoginEvent(password: BlocFormItem(value: text)),
        );
      },
    );
  }

  Widget _buttonEntrar() {
    return DefaultButton(
      text: 'Entrar',
      onPressed: () {
        if (_state.formKey!.currentState!.validate()) {
          _bloc?.add(SubmittedLoginEvent());
        } else {
          AppToast.error('Formulario inválido');
        }
      },
    );
  }
}
