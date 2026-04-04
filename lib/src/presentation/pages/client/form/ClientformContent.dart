import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce_prueba/src/domain/models/City.dart';
import 'package:ecommerce_prueba/src/domain/models/Province.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/form/bloc/ClientFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultButton.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultIconBack.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class ClientFormContent extends StatelessWidget {
  final ClientFormBloc? bloc;
  final ClientFormState state;

  const ClientFormContent(this.bloc, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final isEditing = state.id.isNotEmpty;
    final title = isEditing ? 'Editar cliente' : 'Nuevo cliente';
    final subtitle = isEditing
        ? 'Actualiza la informacion personal, contacto y ubicacion del cliente.'
        : 'Registra un cliente con sus datos de identificacion, contacto y direccion.';

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
                            'Completa los datos personales, identificacion, contacto y ubicacion del cliente.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: const Color(0xff64748B),
                                  height: 1.35,
                                ),
                          ),
                          const SizedBox(height: 22),
                          _FieldBlock(
                            label: 'Nombre completo',
                            helper: '',
                            child: _textNombre(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Tipo de identificacion',
                            helper: '',
                            child: _dropdownTipoIdentificacion(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Numero de identificacion',
                            helper: '',
                            child: _textNumeroIndentificacion(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Correo electronico',
                            helper: '',
                            child: _textEmail(),
                          ),
                          const SizedBox(height: 18),
                          _cardUbicacion(context),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Provincia',
                            helper: '',
                            child: _dropDownProvinciaSearch(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Ciudad',
                            helper: '',
                            child: _dropDownCiudadSearch(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Direccion',
                            helper: '',
                            child: _textDireccion(),
                          ),
                          const SizedBox(height: 18),
                          _FieldBlock(
                            label: 'Telefono',
                            helper: '',
                            child: _textTelefono(),
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
            Positioned(
              top: 12,
              left: 18,
              child: DefaultIconBack(left: 0, top: 0, color: Color(0xff243B6B)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textNombre() {
    return DefaultTextField(
      key: ValueKey('nombre-${state.id}'),
      label: 'Nombre',
      icon: Icons.person_outline_rounded,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.name,
      autofillHints: const [AutofillHints.name],
      initialValue: state.nombre.value,
      onChanged: (text) {
        bloc?.add(
          NombreChangedClientFormEvent(nombre: BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        return state.nombre.error;
      },
      hinText: 'Ej: Juan Perez',
    );
  }

  Widget _dropdownTipoIdentificacion() {
    return DropdownButtonFormField<String>(
      key: ValueKey('tipoIdentificacion-${state.id}'),
      initialValue: state.tipoIdentificacion.isNotEmpty
          ? state.tipoIdentificacion
          : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF8FAFC),
        labelText: 'Tipo de identificacion',
        prefixIcon: const Icon(Icons.badge_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xffD7E3F8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xffD7E3F8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xff4A6CF7)),
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'C', child: Text('Cedula')),
        DropdownMenuItem(value: 'P', child: Text('Pasaporte')),
        DropdownMenuItem(value: 'R', child: Text('RUC')),
      ],
      onChanged: (value) {
        if (value == null) return;
        bloc?.add(
          TipoIdentificacionChangedClientFormEvent(tipoIdentificacion: value),
        );
      },
    );
  }

  Widget _textNumeroIndentificacion() {
    return DefaultTextField(
      key: ValueKey('numeroIdentificacion-${state.id}'),
      label: 'Numero de identificacion',
      icon: Icons.numbers_rounded,
      textInputAction: TextInputAction.next,
      initialValue: state.numeroIdentificacion.value,
      onChanged: (text) {
        bloc?.add(
          NumeroIdentificacionChangedClientFormEvent(
            numeroIdentificacion: BlocFormItem(value: text),
          ),
        );
      },
      validator: (value) {
        return state.numeroIdentificacion.error;
      },
      hinText: 'Ingrese el numero correspondiente',
    );
  }

  Widget _textEmail() {
    return DefaultTextField(
      key: ValueKey('email-${state.id}'),
      label: 'Email',
      icon: Icons.email_outlined,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      initialValue: state.email.value,
      onChanged: (text) {
        bloc?.add(
          EmailChangedClientFormEvent(email: BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        return state.email.error;
      },
      hinText: 'cliente@correo.com',
    );
  }

  Widget _textDireccion() {
    return DefaultTextField(
      key: ValueKey('direccion-${state.id}'),
      label: 'Direccion',
      icon: Icons.location_on_outlined,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.streetAddress,
      initialValue: state.direccion,
      autofillHints: const [AutofillHints.fullStreetAddress],
      onChanged: (text) {
        bloc?.add(DireccionChangedClientFormEvent(direccion: text));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'La direccion es obligatoria';
        }
        return null;
      },
      hinText: 'Av. Principal y calle secundaria',
    );
  }

  Widget _textTelefono() {
    return DefaultTextField(
      key: ValueKey('telefono-${state.id}'),
      label: 'Telefono',
      icon: Icons.phone_outlined,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.phone,
      autofillHints: const [AutofillHints.telephoneNumber],
      initialValue: state.telefono,
      onChanged: (text) {
        bloc?.add(TelefonoChangedClientFormEvent(telefono: text));
      },
      hinText: 'Opcional',
    );
  }

  Widget _dropDownProvinciaSearch() {
    return DropdownSearch<Province>(
      key: ValueKey('provincia-${state.id}'),
      items: (filter, infiniteScrollProps) {
        return state.listaProvincias;
      },
      selectedItem: state.idProvincia.isEmpty
          ? null
          : state.listaProvincias.firstWhereOrNull(
              (x) => x.id == state.idProvincia,
            ),
      itemAsString: (Province x) => x.nombre,
      compareFn: (Province item1, Province item2) => item1.id == item2.id,
      onChanged: (Province? province) {
        if (province == null) return;
        bloc?.add(ProvinciaChangedClientFormEvent(idProvincia: province.id));
      },
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Buscar provincia...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        emptyBuilder: (context, searchEntry) => const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No se encontraron provincias'),
          ),
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF8FAFC),
          labelText: 'Provincia',
          prefixIcon: const Icon(Icons.map_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xffD7E3F8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xffD7E3F8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xff4A6CF7)),
          ),
        ),
      ),
      validator: (Province? province) {
        if (province == null) {
          return 'Seleccione una provincia';
        }
        return null;
      },
    );
  }

  Widget _dropDownCiudadSearch() {
    final ciudades = state.listaCiudades
        .where((x) => x.codigoProvincia == state.codigoProvincia)
        .toList();
    final exists = ciudades.any((x) => x.id == state.idCiudad);

    return DropdownSearch<City>(
      key: ValueKey('ciudad-${state.codigoProvincia}'),
      items: (filter, infiniteScrollProps) {
        if (filter.isEmpty) return ciudades;
        return ciudades
            .where(
              (city) =>
                  city.nombre.toLowerCase().contains(filter.toLowerCase()),
            )
            .toList();
      },
      selectedItem: exists
          ? ciudades.firstWhereOrNull((x) => x.id == state.idCiudad)
          : null,
      itemAsString: (City city) => city.nombre,
      compareFn: (City item1, City item2) => item1.id == item2.id,
      onChanged: state.idProvincia.isEmpty
          ? null
          : (City? city) {
              if (city == null) return;
              bloc?.add(CiudadChangedClientFormEvent(idCiudad: city.id));
            },
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(
            hintText: 'Buscar ciudad...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        emptyBuilder: (context, searchEntry) => const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No se encontraron ciudades'),
          ),
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF8FAFC),
          labelText: 'Ciudad',
          prefixIcon: const Icon(Icons.location_city_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xffD7E3F8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xffD7E3F8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xff4A6CF7)),
          ),
          hintText: state.idProvincia.isEmpty
              ? 'Primero selecciona una provincia'
              : 'Selecciona una ciudad',
        ),
      ),
      validator: (City? city) {
        if (city == null) {
          return 'Seleccione una ciudad';
        }
        return null;
      },
      enabled: state.idProvincia.isNotEmpty,
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
                  'Estado del cliente',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  state.isActive
                      ? 'El cliente estara disponible para usarse en ventas.'
                      : 'El cliente quedara desactivado temporalmente.',
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
              bloc?.add(EstadoChangedClientFormEvent(isActive: value));
            },
          ),
        ],
      ),
    );
  }

  Widget _cardUbicacion(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffEFF6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffBFDBFE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xffDBEAFE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.my_location_rounded,
              color: Color(0xff2563EB),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ubicacion automatica',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Podemos detectar provincia, ciudad y direccion automaticamente para completar mas rapido.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xff64748B),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    bloc?.add(const PickLocationClientFormEvent());
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: const Color(0xff2563EB),
                  ),
                  child: const Text('Usar ubicacion actual'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonActualizar() {
    return DefaultButton(
      text: state.id.isEmpty ? 'Crear cliente' : 'Guardar cambios',
      onPressed: () {
        if (state.formKey!.currentState!.validate()) {
          bloc?.add(const SubmittedClientFormEvent());
        } else {
          AppToast.error('Formulario invalido');
        }
      },
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
              isEditing
                  ? Icons.edit_note_rounded
                  : Icons.person_add_alt_rounded,
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
