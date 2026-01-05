import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListBloc.dart';
import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  CategoryListBloc? _bloc;
  Category _category;
  CategoryListItem(this._bloc, this._category);

  @override
  Widget build(BuildContext context) {
    return Text(_category.descripcion);
  }
}
