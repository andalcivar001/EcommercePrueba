import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/profile/bloc/ProfileState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/utils/SelectOptionImageDialog.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  ProfileBloc? _bloc;
  ProfileState _state;
  User? user;

  ProfileContent(this._bloc, this._state, this.user);

  @override
  Widget build(BuildContext context) {
    return _buildBackground(
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Form(
                  key: _state.formKey,
                  child: _buildCard(
                    child: Column(
                      children: [
                        _imageAvatar(context, _state.imagen, _state.imagenUrl),
                        _buildHeader(),
                        SizedBox(height: 32),
                        _textNombre(),
                        SizedBox(height: 16),
                        _textTelefono(),
                        SizedBox(height: 16),
                        _textFechaNacimiento(context),
                        SizedBox(height: 28),
                        _buttonActualizar(),
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

  Widget _buildBackground({required Widget child}) {
    return Container(color: Colors.white, child: child);
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Actualizar Perfil',
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

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF1E3C72), // azul corporativo
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _imageAvatar(
    BuildContext context,
    File? imagenState,
    String? imagenUser,
  ) {
    const primary = Color(0xFF1E3C72);

    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context,
          () => _bloc?.add(PickImageProfileEvent()),
          () => _bloc?.add(TakePhotoProfileEvent()),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: primary, width: 2),
            ),
            child: ClipOval(
              child: imagenState != null
                  ? Image.file(imagenState, fit: BoxFit.fill)
                  : imagenUser != null && imagenUser.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      image: imagenUser,
                      placeholder: 'assets/img/user_image.png',
                      fit: BoxFit.fill,
                      fadeInDuration: Duration(seconds: 1),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/img/user_image.png',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 45,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Seleccionar imagen',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textNombre() {
    return DefaultTextField(
      label: 'Nombre',
      icon: Icons.person,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      initialValue: user?.nombre ?? '',
      onChanged: (text) {
        _bloc?.add(
          NombreChangedProfileEvent(nombre: BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        return _state.nombre.error;
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
      initialValue: user?.telefono ?? '',
      onChanged: (text) {
        _bloc?.add(
          TelefonoChangedProfileEvent(telefono: BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        return _state.telefono.error;
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
      initialValue: user?.fechaNacimiento!,
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
          FechaNacimientoProfileEvent(
            fechaNacimiento: BlocFormItem(value: formatted),
          ),
        );
      },
      validator: (_) => _state.fechaNacimiento.error,
    );
  }

  Widget _buttonActualizar() {
    return DefaultButton(
      text: 'Actualizar',
      onPressed: () {
        if (_state.formKey!.currentState!.validate()) {
          _bloc?.add(FormSubmittedProfileEvent());
        } else {
          AppToast.error('Formulario inválido');
        }
      },
    );
  }
}
