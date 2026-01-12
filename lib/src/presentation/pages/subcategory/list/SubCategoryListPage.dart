import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/SubCategoryListItem.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryListPage extends StatefulWidget {
  const SubCategoryListPage({super.key});

  @override
  State<SubCategoryListPage> createState() => _SubCategoryListPageState();
}

class _SubCategoryListPageState extends State<SubCategoryListPage> {
  SubCategoryListBloc? bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<SubCategoryListBloc>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'subcategory/form');
        },
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: BlocListener<SubCategoryListBloc, SubCategoryListState>(
        listener: (context, state) {
          final responseState = state.response;
          if (responseState is Error) {
            AppToast.error(responseState.message);
          }

          final responseDeleteState = state.responseDelete;
          if (responseDeleteState is Success) {
            AppToast.success('Categoria eliminada correctamente');
            bloc?.add(InitSubCategoryListEvent());
          } else if (responseDeleteState is Error) {
            AppToast.error(responseDeleteState.message);
          }
        },
        child: BlocBuilder<SubCategoryListBloc, SubCategoryListState>(
          builder: (context, state) {
            final response = state.response;
            final responseDelete = state.responseDelete;
            if (response is Success) {
              List<SubCategory> subcategories =
                  response.data as List<SubCategory>;

              return Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  children: [
                    Text(
                      'Subcategorias',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        color: Colors.black87,
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
                      child: subcategories.length > 0
                          ? TextField(
                              //  controller: SearchController(),
                              onChanged: (text) {
                                bloc?.add(
                                  BusquedaChangedSubCategoryListEvent(
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

                    const SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: subcategories.length == 0
                          ? Text(
                              'No hay subcategorias creadas',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: subcategories.length,
                        itemBuilder: (context, index) {
                          return SubCategoryListItem(
                            bloc,
                            subcategories[index],
                          );
                        },
                      ),
                    ),
                    Text(
                      'Cantidad de Subcategorias: ${subcategories.length.toString()}',
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
