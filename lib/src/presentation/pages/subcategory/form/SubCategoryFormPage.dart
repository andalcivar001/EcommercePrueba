import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubCategoryFormPage extends StatefulWidget {
  const SubCategoryFormPage({super.key});

  @override
  State<SubCategoryFormPage> createState() => _SubCategoryFormPageState();
}

class _SubCategoryFormPageState extends State<SubCategoryFormPage> {
  SubCategory? subCategory;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      subCategory = ModalRoute.of(context)?.settings.arguments as SubCategory;
    }
    return Scaffold(
      body: Center(child: Text('Subcategoria ${subCategory?.nombre}')),
    );
  }
}
