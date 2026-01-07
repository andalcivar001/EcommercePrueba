import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/CategoryFormContent.dart';
import 'package:flutter/material.dart';

class CategoryFormPage extends StatefulWidget {
  const CategoryFormPage({super.key});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  Category? category;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      category = ModalRoute.of(context)?.settings.arguments as Category;
    }
    print('CATEGORY ${category?.toJson()}');
    return Scaffold(body: CategoryFormContent(category));
  }
}
