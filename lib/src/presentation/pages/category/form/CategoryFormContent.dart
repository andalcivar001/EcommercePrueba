import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class CategoryFormContent extends StatelessWidget {
  final Category? category;
  final CategoryFormBloc? bloc;
  final CategoryFormState state;

  const CategoryFormContent(this.bloc, this.state, this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    final isEditing = category != null;
    final title = isEditing ? 'Editar categoria' : 'Nueva categoria';
    final subtitle = isEditing
        ? 'Actualiza la informacion y manten organizada tu lista de productos.'
        : 'Crea una categoria clara y elegante para clasificar tus productos.';

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffEEF4FF), Color(0xffF9FBFF), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -70,
              right: -20,
              child: _BackgroundBubble(
                size: 180,
                colors: [Color(0xffDCE8FF), Color(0xffEEF4FF)],
              ),
            ),
            const Positioned(
              top: 110,
              left: -55,
              child: _BackgroundBubble(
                size: 130,
                colors: [Color(0xffEAF7F1), Color(0xffF5FBF7)],
              ),
            ),
            DefaultIconBack(left: 18, top: 12, color: const Color(0xff243B6B)),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 72, 22, 24),
              child: Form(
                key: state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeroHeader(
                      title: title,
                      subtitle: subtitle,
                      isEditing: isEditing,
                    ),
                    const SizedBox(height: 20),
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
                          Text(
                            'Informacion general',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff1E293B),
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Define el nombre, una breve descripcion y el estado de la categoria.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: const Color(0xff64748B),
                                  height: 1.35,
                                ),
                          ),
                          const SizedBox(height: 22),
                          _FieldBlock(
                            label: 'Nombre de la categoria',
                            helper: '',
                            child: _textNombre(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Descripcion',
                            helper: '',
                            child: _textDescripcion(),
                          ),
                          const SizedBox(height: 18),
                          _switchEstado(context),
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
      icon: Icons.sell_outlined,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (text) {
        bloc?.add(
          NombreChangedCategoryFormEvent(nombre: BlocFormItem(value: text)),
        );
      },
      initialValue: category?.nombre,
      validator: (value) {
        return state.nombre.error;
      },
      hinText: 'Ej: Bebidas, Tecnologia, Hogar',
    );
  }

  Widget _textDescripcion() {
    return DefaultTextField(
      label: 'Descripcion',
      maxLines: 4,
      icon: Icons.notes_rounded,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (text) {
        bloc?.add(
          DescripcionChangedCategoryFormEvent(
            descripcion: BlocFormItem(value: text),
          ),
        );
      },
      initialValue: category?.descripcion,
      validator: (value) {
        return state.descripcion.error;
      },
      hinText: 'Describe brevemente el tipo de productos que agrupa',
    );
  }

  Widget _buttonActualizar() {
    return DefaultButton(
      text: category == null ? 'Crear categoria' : 'Guardar cambios',
      onPressed: () {
        if (state.formKey!.currentState!.validate()) {
          bloc?.add(FormSubmittedCategoryFormEvent());
        } else {
          AppToast.error('Formulario invalido');
        }
      },
    );
  }

  Widget _switchEstado(BuildContext context) {
    final activeColor = const Color(0xff16A34A);
    final inactiveColor = const Color(0xff94A3B8);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (state.isActive ? activeColor : inactiveColor).withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              state.isActive ? Icons.check_circle_outline : Icons.pause_circle,
              color: state.isActive ? activeColor : inactiveColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estado de la categoria',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  state.isActive
                      ? 'La categoria estara disponible para usarse.'
                      : 'La categoria quedara desactivada temporalmente.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xff64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: state.isActive,
            activeThumbColor: Colors.white,
            activeTrackColor: activeColor,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xffCBD5E1),
            onChanged: (value) {
              bloc?.add(EstadoChangedCategoryFormEvent(isActive: value));
            },
          ),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isEditing;

  const _HeroHeader({
    required this.title,
    required this.subtitle,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
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
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: Icon(
              isEditing ? Icons.edit_note_rounded : Icons.add_business_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
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

class _FieldBlock extends StatelessWidget {
  final String label;
  final String helper;
  final Widget child;

  const _FieldBlock({
    required this.label,
    required this.helper,
    required this.child,
  });

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
        const SizedBox(height: 5),
        Text(
          helper,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: const Color(0xff64748B)),
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
