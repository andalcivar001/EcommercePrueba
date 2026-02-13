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
      color: Colors.white,
      height: double.infinity,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Nueva Orden',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 10,
              ),

              child: Form(
                key: state.formKey,

                child: Column(
                  children: [
                    Container(
                      width: double.infinity,

                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1.5,
                        ),
                      ),
                      child: Container(
                        color: Colors.white,
                        child: _dropDownProvinciaSearch(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Agregar Producto',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 1, right: 3),
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Expanded(
                    //       flex: 5,
                    //       child: Container(
                    //         color: Colors.blue,
                    //         child: Text('Buscar Producto'),
                    //       ),
                    //     ),
                    //     Expanded(
                    //       flex: 5,
                    //       child: Container(
                    //         color: Colors.white,
                    //         child: Text('Buscar QR'),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
          prefixIcon: Icon(Icons.person),
          border: OutlineInputBorder(),
          errorText: state.idCliente.isEmpty
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
