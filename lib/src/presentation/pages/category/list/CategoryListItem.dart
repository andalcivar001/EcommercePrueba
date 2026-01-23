import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/list/bloc/CategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/utils/SelectConfirmDialog.dart';
import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  Category _category;
  CategoryListBloc? bloc;
  CategoryListItem(this.bloc, this._category);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          _category.nombre,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'category/form',
                  arguments: _category,
                );
              },
              icon: Icon(Icons.edit, color: Colors.blue),
            ),
            IconButton(
              onPressed: () {
                selectConfirmDialog(
                  context,
                  () => bloc?.add(DeleteCategoryListEvent(id: _category.id)),
                );
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
