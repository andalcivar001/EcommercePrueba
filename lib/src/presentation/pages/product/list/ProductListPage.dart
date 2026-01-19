import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/ProductListItem.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductListBloc? bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProductListBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: BlocListener<ProductListBloc, ProductListState>(
        listener: (context, state) {
          final responseState = state.response;
          if (responseState is Error) {
            AppToast.error(
              'Error al cargar los productos ${responseState.message}',
            );
          }
          final responseDeleteState = state.responseDelete;
          if (responseDeleteState is Success) {
            AppToast.success('Categoria eliminada correctamente');
            bloc?.add(InitProductListEvent());
          } else if (responseDeleteState is Error) {
            AppToast.error(
              'Error eliminando el producto ${responseDeleteState.message}',
            );
          }
        },
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            final response = state.response;
            final responseDelete = state.responseDelete;
            if (response is Success) {
              List<Product> products = response.data as List<Product>;
              return Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Productos',
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
                      child:
                          products.isNotEmpty || state.listaProduct!.isNotEmpty
                          ? TextField(
                              //  controller: SearchController(),
                              onChanged: (text) {
                                bloc?.add(
                                  BusquedaChangedProductListEvent(
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
                      child: products.length == 0
                          ? Text(
                              'No hay productos creados',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Productlistitem(bloc, products[index]);
                        },
                      ),
                    ),
                    Text(
                      'Cantidad de productos: ${products.length.toString()}',
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
