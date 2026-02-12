import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/order/form/bloc/OrderFormState.dart';
import 'package:flutter/material.dart';

class OrderFormContent extends StatelessWidget {
  OrderFormBloc? bloc;
  OrderFormState state;
  OrderFormContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text('OrderFormContent'),
    );
  }

  Widget _dropDownProvinciaSearch() {
    return DropdownSearch<Client>(
      // Items como función
      items: (filter, infiniteScrollProps) {
        return state.listaClientes;
      },

      // Valor seleccionado
      selectedItem: state.idCliente!.isEmpty
          ? null
          : state.listaClientes.firstWhereOrNull(
              (x) => x.id == state.idCliente,
            ),

      // Cómo mostrar cada item
      itemAsString: (Client x) => x.nombre,

      compareFn: (Client item1, Client item2) => item1.id == item2.id,

      // Cuando cambia la selección
      onChanged: (Client? cliente) {
        bloc?.add(ClienteChagnedOrderFormEvent(idCliente: cliente!.id));
      },
      // Configuración del popup de búsqueda
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Buscar cliente...",
            prefixIcon: Icon(Icons.search),
          ),
        ),
        emptyBuilder: (context, searchEntry) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('No se encontraron clientes'),
          ),
        ),
      ),

      // Decoración del dropdown
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: 'Cliente',
          prefixIcon: Icon(Icons.map),
          border: OutlineInputBorder(),
          errorText: state.idCliente!.isEmpty
              ? 'Primero seleccione un cliente'
              : null,
        ),
      ),

      // Validación
      validator: (Client? city) {
        if (city == null) {
          return 'Seleccione un cliente';
        }
        return null;
      },
    );
  }
}
