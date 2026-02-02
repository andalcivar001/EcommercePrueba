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
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 80, left: 24, right: 24),

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
                    _dropDownProvincias(),
                    SizedBox(height: 16),
                    _dropDownCiudad(),
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
    return DropdownButtonFormField<String>(
      key: ValueKey('tipoIdentificacion-${state.id}'),
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

  Widget _dropdownNumeroIdentificacion() {
    return DropdownSearch<String>(
      key: ValueKey('numeroIdentificacion-${state.id}'),

      // Configuración de items
      items: (filter, infiniteScrollProps) => [
        "1234567890",
        "0987654321",
        "1122334455",
        // Agrega tus números de identificación aquí
      ],

      // Valor seleccionado
      selectedItem: state.nombre.value.isNotEmpty ? state.nombre.value : null,

      // Cuando cambia la selección
      onChanged: (String? newValue) {
        if (newValue != null) {
          bloc?.add(
            NumeroIdentificacionChangedClientFormEvent(
              numeroIdentificacion: BlocFormItem(value: newValue),
            ),
          );
        }
      },

      // Configuración de búsqueda
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Buscar...",
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),

      // Decoración del dropdown (versión actualizada)
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: "# de Identificación",
          prefixIcon: Icon(Icons.numbers),
          errorText: state.nombre.error,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _textNumeroIndentificacion() {
    return DefaultTextField(
      key: ValueKey('numeroIdentificacion-${state.id}'),

      label: '# de Identificación',
      icon: Icons.numbers,
      textInputAction: TextInputAction.next,
      initialValue: state.nombre.value,
      onChanged: (text) {
        bloc?.add(
          NumeroIdentificacionChangedClientFormEvent(
            numeroIdentificacion: BlocFormItem(value: text),
          ),
        );
      },
      validator: (value) {
        return state.nombre.error;
      },
    );
  }

  Widget _dropDownProvincias() {
    final idExists = state.id;
    return DropdownButtonFormField<String>(
      initialValue: idExists.isNotEmpty ? state.idProvincia : null,
      decoration: const InputDecoration(
        labelText: 'Provincia',
        prefixIcon: Icon(Icons.map),
        border: OutlineInputBorder(),
      ),
      items: state.listaProvincias.map((Province x) {
        return DropdownMenuItem<String>(value: x.id, child: Text(x.nombre));
      }).toList(),
      onChanged: (value) {
        if (value == null) return;
        bloc?.add(ProvinciaChangedClientFormEvent(idProvincia: value));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Seleccione una provincia';
        }
        return null;
      },
    );
  }

  Widget _dropDownCiudad() {
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
          ? subs.firstWhere((x) => x.id == state.idCiudad)
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
          prefixIcon: Icon(Icons.maps_home_work_rounded),
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
