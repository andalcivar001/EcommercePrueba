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
import 'package:ecommerce_prueba/src/presentation/widgets/DefaultTextField.dart';
import 'package:flutter/material.dart';

class ClientFormContent extends StatelessWidget {
  ClientFormBloc? bloc;
  ClientFormState state;
  ClientFormContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    final dropDownKey = GlobalKey<DropdownSearchState>();

    return Container(
      color: Colors.white,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 20),

            child: Form(
              key: state.formKey,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
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
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Mantenimiento de Clientes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    _textNombre(),
                    SizedBox(height: 16),
                    _dropdownTipoIdentificacion(),
                    SizedBox(height: 16),
                    _textNumeroIndentificacion(),
                    SizedBox(height: 16),
                    _textEmail(),
                    SizedBox(height: 16),
                    _cardUbicacion(),
                    SizedBox(height: 16),
                    _dropDownProvinciaSearch(),
                    SizedBox(height: 16),
                    _dropDownCiudadSearch(),
                    SizedBox(height: 16),
                    _textDireccion(),
                    SizedBox(height: 16),
                    _textTelefono(),
                    SizedBox(height: 16),
                    _switchEstado(),
                    SizedBox(height: 16),
                    _buttonActualizar(),
                    // Aquí van los campos del formulario
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textNombre() {
    return DefaultTextField(
      key: ValueKey('nombre-${state.id}'),

      label: 'Nombre',
      icon: Icons.edit,
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
    );
  }

  Widget _dropdownTipoIdentificacion() {
    final idExists = state.id;
    return DropdownButtonFormField<String>(
      key: ValueKey('tipoIdentificacion-${state.id}'),
      initialValue: idExists.isNotEmpty ? state.tipoIdentificacion : null,
      decoration: const InputDecoration(
        labelText: 'Tipo de identificación',
        prefixIcon: Icon(Icons.badge),
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 'C', child: Text('Cédula')),
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

      label: '# de Identificación',
      icon: Icons.numbers,
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
    );
  }

  Widget _textEmail() {
    return DefaultTextField(
      key: ValueKey('email-${state.id}'),

      label: 'Email',
      icon: Icons.email,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.emailAddress,
      initialValue: state.email.value,
      autofillHints: const [AutofillHints.email],
      onChanged: (text) {
        bloc?.add(
          EmailChangedClientFormEvent(email: BlocFormItem(value: text)),
        );
      },
      validator: (value) {
        return state.email.error;
      },
    );
  }

  Widget _textDireccion() {
    return DefaultTextField(
      key: ValueKey('direccion-${state.id}'),

      label: 'Direccion',
      icon: Icons.location_on,
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.streetAddress,
      initialValue: state.direccion,
      autofillHints: const [AutofillHints.addressState],
      onChanged: (text) {
        bloc?.add(DireccionChangedClientFormEvent(direccion: text));
      },
      validator: (value) {
        if (value == null || value == '') {
          return 'La direccion es obligatorio';
        }
        return null;
      },
    );
  }

  Widget _textTelefono() {
    return DefaultTextField(
      key: ValueKey('telefono-${state.id}'),

      label: 'Teléfono',
      icon: Icons.phone,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.phone,
      autofillHints: const [AutofillHints.telephoneNumber],
      initialValue: state.telefono,
      onChanged: (text) {
        bloc?.add(TelefonoChangedClientFormEvent(telefono: text));
      },
    );
  }

  Widget _dropDownProvinciaSearch() {
    return DropdownSearch<Province>(
      key: ValueKey('provincia-${state.id}'),

      // Items como función
      items: (filter, infiniteScrollProps) {
        return state.listaProvincias;
      },

      // Valor seleccionado
      selectedItem: state.idProvincia.isEmpty
          ? null
          : state.listaProvincias.firstWhereOrNull(
              (x) => x.id == state.idProvincia,
            ),

      // Cómo mostrar cada item
      itemAsString: (Province x) => x.nombre,

      compareFn: (Province item1, Province item2) => item1.id == item2.id,

      // Cuando cambia la selección
      onChanged: (Province? province) {
        bloc?.add(ProvinciaChangedClientFormEvent(idProvincia: province!.id));
      },
      // Configuración del popup de búsqueda
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Buscar provincia...",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        emptyBuilder: (context, searchEntry) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('No se encontraron provincias'),
          ),
        ),
      ),

      // Decoración del dropdown
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: 'Provincia',
          prefixIcon: Icon(Icons.map),
          border: OutlineInputBorder(),
          errorText: state.idProvincia.isEmpty
              ? 'Primero seleccione una provincia'
              : null,
        ),
      ),

      // Validación
      validator: (Province? city) {
        if (city == null) {
          return 'Seleccione una provincia';
        }
        return null;
      },
    );
  }

  Widget _dropDownCiudadSearch() {
    final subs = state.listaCiudades
        .where((x) => x.codigoProvincia == state.codigoProvincia)
        .toList();
    final exists = subs.any((x) => x.id == state.idCiudad);

    return DropdownSearch<City>(
      key: ValueKey('ciudad-${state.codigoProvincia}'),

      // Items como función
      items: (filter, infiniteScrollProps) {
        if (filter.isEmpty) {
          return subs;
        }
        return subs
            .where(
              (city) =>
                  city.nombre.toLowerCase().contains(filter.toLowerCase()),
            )
            .toList();
      },

      // Valor seleccionado
      selectedItem: exists
          ? subs.firstWhereOrNull((x) => x.id == state.idCiudad)
          : null,

      // Cómo mostrar cada item
      itemAsString: (City city) => city.nombre,

      compareFn: (City item1, City item2) => item1.id == item2.id,

      // Cuando cambia la selección
      onChanged: state.idProvincia.isEmpty
          ? null
          : (City? city) {
              if (city != null) {
                bloc?.add(CiudadChangedClientFormEvent(idCiudad: city.id));
              }
            },

      // Configuración del popup de búsqueda
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Buscar ciudad...",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        emptyBuilder: (context, searchEntry) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('No se encontraron ciudades'),
          ),
        ),
      ),

      // Decoración del dropdown
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: 'Ciudad',
          prefixIcon: Icon(Icons.location_city),
          border: OutlineInputBorder(),
          errorText: state.idProvincia.isEmpty
              ? 'Primero seleccione una provincia'
              : null,
        ),
      ),

      // Validación
      validator: (City? city) {
        if (city == null) {
          return 'Seleccione una ciudad';
        }
        return null;
      },

      // Deshabilitar si no hay provincia seleccionada
      enabled: state.idProvincia.isNotEmpty,
    );
  }

  Widget _switchEstado() {
    return SwitchListTile(
      title: Text('Estado:', style: TextStyle(fontSize: 14)),
      value: state.isActive,
      onChanged: (value) {
        bloc?.add(EstadoChangedClientFormEvent(isActive: value));
      },
      activeThumbColor: Colors.white,
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey.shade300,
    );
  }

  Widget _cardUbicacion() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blue),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Podemos detectar tu ubicación para completar provincia, ciudad y dirección automaticamente',
              style: TextStyle(fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: () {
              bloc?.add(PickLocationClientFormEvent());
            },
            child: Text('Usar'),
          ),
        ],
      ),
    );
  }

  Widget _buttonActualizar() {
    return DefaultButton(
      text: state.id.isEmpty ? 'Crear' : 'Actualizar',
      onPressed: () {
        if (state.formKey!.currentState!.validate()) {
          bloc?.add(SubmittedClientFormEvent());
        } else {
          AppToast.error('Formulario inválido');
        }
      },
    );
  }
}
