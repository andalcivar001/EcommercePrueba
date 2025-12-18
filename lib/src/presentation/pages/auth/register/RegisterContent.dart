import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/auth/register/bloc/RegisterState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:flutter/material.dart';

class RegisterContent extends StatelessWidget {
  RegisterBloc? _bloc;
  RegisterState _state;

  RegisterContent(this._bloc, this._state);
  @override
  Widget build(BuildContext context) {
    return _buildBackground(
      child: SafeArea(
        child: Stack(
          children: [
            // 🔹 Icono Back FUERA del Card
            Positioned(child: DefaultIconBack(left: 18, top: 5)),

            // 🔹 Card centrado
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _state.formKey,
                  child: _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 32),
                        _textNombre(),
                        const SizedBox(height: 16),
                        _textEmail(),
                        const SizedBox(height: 16),
                        _textTelefono(),
                        const SizedBox(height: 16),
                        const SizedBox(height: 16),
                        _textPassword(),
                        const SizedBox(height: 16),
                        _textConfirmPassword(),
                        const SizedBox(height: 16),
                        _textFechaNacimiento(context),
                        const SizedBox(height: 28),
                        _buttonCrear(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ====== Widgets privados "clave" (no todos) ======

  Widget _buildBackground({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
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
      child: child,
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Crear cuenta',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        const Text(
          'Ingrese los datos',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  // ====== Tus widgets existentes ======

  Widget _textNombre() {
    return DefaultTextField(
      label: 'Nombre',
      icon: Icons.person,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      onChanged: (text) {
        _bloc?.add(NameChangedRegisterEvent(nombre: BlocFormItem(value: text)));
      },
      validator: (value) {
        return _state.nombre.error;
      },
    );
  }

  Widget _textEmail() {
    return DefaultTextField(
      label: 'Correo electronico',
      icon: Icons.email_outlined,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      textInputType: TextInputType.emailAddress,
      onChanged: (text) {
        _bloc?.add(EmailChangedRegisterEvent(email: BlocFormItem(value: text)));
      },
      validator: (value) {
        return _state.email.error;
      },
    );
  }

  Widget _textTelefono() {
    return DefaultTextField(
      label: 'Teléfono',
      icon: Icons.phone,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.telephoneNumber],
      textInputType: TextInputType.number,
      onChanged: (text) {
        _bloc?.add(
          TelefonoChangedRegisterEvent(telefono: BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        return _state.telefono.error;
      },
    );
  }

  Widget _textPassword() {
    return DefaultTextField(
      label: 'Contraseña',
      icon: Icons.lock_outline,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.password],

      validator: (value) {
        return _state.password.error;
      },
      obscureText: true,
      onChanged: (text) {
        _bloc?.add(
          PasswordChangedRegisterEvent(password: BlocFormItem(value: text)),
        );
      },
    );
  }

  Widget _textConfirmPassword() {
    return DefaultTextField(
      label: 'Confirme Contraseña',
      icon: Icons.lock_outline,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.newPassword],

      validator: (value) {
        return _state.confirmPassword.error;
      },
      obscureText: true,
      onChanged: (text) {
        _bloc?.add(
          ConfirmPasswordChangedRegisterEvent(
            confirmPassword: BlocFormItem(value: text),
          ),
        );
      },
    );
  }

  Widget _textFechaNacimiento(BuildContext context) {
    final controller = TextEditingController(
      text: _state
          .fechaNacimiento
          .value, // aquí debe estar el string "dd/MM/yyyy"
    );

    return DefaultTextField(
      label: 'Fecha de nacimiento',
      icon: Icons.calendar_month_outlined,
      controller: controller,
      readOnly: true,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (picked == null) return;

        final formatted =
            "${picked.year}-"
            "${picked.month.toString().padLeft(2, '0')}-"
            "${picked.day.toString().padLeft(2, '0')}";

        _bloc?.add(
          FechaNacimientoChangedRegisterEvent(
            fechaNacimiento: BlocFormItem(value: formatted),
          ),
        );
      },
      validator: (_) => _state.fechaNacimiento.error,
    );
  }

  Widget _buttonCrear() {
    return DefaultButton(
      text: 'Crear',
      onPressed: () {
        if (_state.formKey!.currentState!.validate()) {
          _bloc?.add(SubmittedRegisterEvent());
        } else {
          AppToast.error('Formulario inválido');
        }
      },
    );
  }
}
