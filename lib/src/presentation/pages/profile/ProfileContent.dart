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
  final ProfileBloc? bloc;
  final ProfileState state;
  final User? user;

  const ProfileContent(this.bloc, this.state, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffEEF4FF), Color(0xffF8FBFF), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -70,
              right: -20,
              child: _BackgroundBubble(
                size: 190,
                colors: [Color(0xffDCE8FF), Color(0xffEEF4FF)],
              ),
            ),
            const Positioned(
              top: 130,
              left: -50,
              child: _BackgroundBubble(
                size: 130,
                colors: [Color(0xffEAF7F1), Color(0xffF6FCF8)],
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
              child: Form(
                key: state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeroHeader(user: user),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: const Color(0xffD7E3F8)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xff24408E,
                            ).withValues(alpha: 0.10),
                            blurRadius: 28,
                            spreadRadius: -10,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: _ImageAvatar(
                              bloc: bloc,
                              imagenState: state.imagen,
                              imagenUser: state.imagenUrl ?? user?.imagen,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Text(
                            'Informacion personal',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xff1E293B),
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Actualiza tu nombre, telefono, fecha de nacimiento e imagen de perfil.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: const Color(0xff64748B),
                                  height: 1.35,
                                ),
                          ),
                          const SizedBox(height: 22),
                          _FieldBlock(
                            label: 'Nombre completo',
                            child: _textNombre(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Telefono',
                            child: _textTelefono(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Fecha de nacimiento',
                            child: _textFechaNacimiento(context),
                          ),
                          const SizedBox(height: 24),
                          _buttonActualizar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textNombre() {
    return DefaultTextField(
      label: 'Nombre',
      icon: Icons.person_outline_rounded,
      textInputType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      initialValue: user?.nombre ?? '',
      onChanged: (text) {
        bloc?.add(NombreChangedProfileEvent(nombre: BlocFormItem(value: text)));
      },
      validator: (value) {
        return state.nombre.error;
      },
      hinText: 'Ej: Juan Perez',
    );
  }

  Widget _textTelefono() {
    return DefaultTextField(
      label: 'Telefono',
      icon: Icons.phone_outlined,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.telephoneNumber],
      textInputType: TextInputType.phone,
      initialValue: user?.telefono ?? '',
      onChanged: (text) {
        bloc?.add(
          TelefonoChangedProfileEvent(telefono: BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        return state.telefono.error;
      },
      hinText: '0987654321',
    );
  }

  Widget _textFechaNacimiento(BuildContext context) {
    final controller = TextEditingController(text: state.fechaNacimiento.value);

    return DefaultTextField(
      label: 'Fecha de nacimiento',
      icon: Icons.calendar_month_outlined,
      controller: controller,
      readOnly: true,
      initialValue: user?.fechaNacimiento,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (picked == null) return;

        final formatted =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

        bloc?.add(
          FechaNacimientoProfileEvent(
            fechaNacimiento: BlocFormItem(value: formatted),
          ),
        );
      },
      validator: (_) => state.fechaNacimiento.error,
      hinText: 'Selecciona una fecha',
    );
  }

  Widget _buttonActualizar() {
    return DefaultButton(
      text: 'Guardar cambios',
      onPressed: () {
        if (state.formKey!.currentState!.validate()) {
          bloc?.add(FormSubmittedProfileEvent());
        } else {
          AppToast.error('Formulario invalido');
        }
      },
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final User? user;

  const _HeroHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    final email = (user?.email ?? '').trim();

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff1D4ED8), Color(0xff2563EB), Color(0xff60A5FA)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff2563EB).withValues(alpha: 0.24),
            blurRadius: 30,
            spreadRadius: -10,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: const Icon(
              Icons.manage_accounts_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mi perfil',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  email.isNotEmpty
                      ? email
                      : 'Gestiona tu informacion personal y tu foto de perfil.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.90),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageAvatar extends StatelessWidget {
  final ProfileBloc? bloc;
  final File? imagenState;
  final String? imagenUser;

  const _ImageAvatar({
    required this.bloc,
    required this.imagenState,
    required this.imagenUser,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SelectOptionImageDialog(
          context,
          () => bloc?.add(PickImageProfileEvent()),
          () => bloc?.add(TakePhotoProfileEvent()),
        );
      },
      child: Column(
        children: [
          Container(
            width: 116,
            height: 116,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff3154F6), Color(0xff6AA4FF)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff3154F6).withValues(alpha: 0.22),
                  blurRadius: 24,
                  spreadRadius: -8,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipOval(child: _buildAvatarImage()),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffEEF4FF),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Cambiar foto',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: const Color(0xff3154F6),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarImage() {
    if (imagenState != null) {
      return Image.file(imagenState!, fit: BoxFit.cover);
    }

    if (imagenUser != null && imagenUser!.isNotEmpty) {
      return FadeInImage.assetNetwork(
        image: imagenUser!,
        placeholder: 'assets/img/user_image.png',
        fit: BoxFit.cover,
        fadeInDuration: const Duration(seconds: 1),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/img/user_image.png', fit: BoxFit.cover);
        },
      );
    }

    return Container(
      color: Colors.white,
      child: const Center(
        child: Icon(Icons.person_rounded, size: 54, color: Color(0xff3154F6)),
      ),
    );
  }
}

class _FieldBlock extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldBlock({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xff1E293B),
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _BackgroundBubble extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const _BackgroundBubble({required this.size, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
    );
  }
}
