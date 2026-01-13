import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/CategoryListItem.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  CategoryListBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<CategoryListBloc>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'category/form');
        },
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: BlocListener<CategoryListBloc, CategoryListState>(
        listener: (context, state) {
          final responseState = state.response;
          // if (responseState is Success) {
          //   AppToast.success('Categoria eliminada correctamente');
          //   _bloc?.add(InitCategoryListEvent());
          // }
          if (responseState is Error) {
            AppToast.error(responseState.message);
          }

          final responseDeleteState = state.responseDelete;
          if (responseDeleteState is Success) {
            AppToast.success('Categoria eliminada correctamente');
            _bloc?.add(InitCategoryListEvent());
          } else if (responseDeleteState is Error) {
            AppToast.error(responseDeleteState.message);
          }
        },
        child: BlocBuilder<CategoryListBloc, CategoryListState>(
          builder: (context, state) {
            final response = state.response;
            final responseDelete = state.responseDelete;
            if (response is Success) {
              List<Category> categories = response.data as List<Category>;
              return Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Categorias',
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
                          categories.isNotEmpty ||
                              state.listaCategoryResp!.isNotEmpty
                          ? TextField(
                              //  controller: SearchController(),
                              onChanged: (text) {
                                _bloc?.add(
                                  BusquedaChangedListEvent(busqueda: text),
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

                    const SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: categories.length == 0
                          ? Text(
                              'No hay categorias creadas',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryListItem(_bloc, categories[index]);
                        },
                      ),
                    ),
                    Text(
                      'Cantidad de categorias: ${categories.length.toString()}',
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
