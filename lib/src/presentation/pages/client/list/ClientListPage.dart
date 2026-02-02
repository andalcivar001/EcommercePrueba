import 'package:ecommerce_prueba/src/domain/models/Client.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/ClientListItem.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/client/list/bloc/ClientListState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  ClientListBloc? bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ClientListBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'client/form');
        },
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: BlocListener<ClientListBloc, ClientListState>(
        listener: (context, state) {
          final responseState = state.response;
          if (responseState is Error) {
            AppToast.error(
              'Error al cargar los clientes ${responseState.message}',
            );
          }
          final responseDeleteState = state.responseDelete;
          if (responseDeleteState is Success) {
            AppToast.success('Cliente eliminado correctamente');
            bloc?.add(InitClientListEvent());
          } else if (responseDeleteState is Error) {
            AppToast.error(
              'Error eliminando el cliente ${responseDeleteState.message}',
            );
          }
        },
        child: BlocBuilder<ClientListBloc, ClientListState>(
          builder: (context, state) {
            final response = state.response;
            final responseDelete = state.responseDelete;
            if (response is Success) {
              List<Client> clients = response.data as List<Client>;
              return Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Clientes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),

                      width: double.infinity,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E3C72),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      child: clients.isNotEmpty || state.listaClient!.isNotEmpty
                          ? TextField(
                              //  controller: SearchController(),
                              onChanged: (text) {
                                bloc?.add(
                                  BusquedaChangedClientListEvent(
                                    busqueda: text,
                                  ),
                                );
                              },
                              decoration: InputDecoration(
                                hintText: 'Buscar...',
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: clients.isEmpty
                          ? Text(
                              'No hay clientes creados',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: clients.length,
                        itemBuilder: (context, index) {
                          return ClientListItem(bloc, clients[index]);
                        },
                      ),
                    ),
                    Text(
                      'Cantidad de clientes: ${clients.length.toString()}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }

            if (response is Loading || responseDelete is Loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
