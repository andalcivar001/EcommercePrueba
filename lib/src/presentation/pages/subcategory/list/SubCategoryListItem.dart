import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/utils/SelectConfirmDialog.dart';
import 'package:flutter/material.dart';

class SubCategoryListItem extends StatelessWidget {
  SubCategoryListBloc? bloc;
  SubCategory subCategory;
  Category category;

  SubCategoryListItem(this.bloc, this.subCategory, this.category);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          subCategory.nombre,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          category.nombre,
          style: TextStyle(fontSize: 13, color: Colors.black),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'subcategory/form',
                  arguments: subCategory,
                );
              },
              icon: Icon(Icons.edit, color: Colors.blue),
            ),
            IconButton(
              onPressed: () {
                selectConfirmDialog(
                  context,
                  () =>
                      bloc?.add(DeleteSubCategoryListEvent(id: subCategory.id)),
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
