import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/CategoryFormContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/category/form/bloc/CategoryFormState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryFormPage extends StatefulWidget {
  const CategoryFormPage({super.key});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  Category? category;
  CategoryFormBloc? bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc?.add(InitCategoryFormEvent(category: category));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      category = ModalRoute.of(context)?.settings.arguments as Category;
    }
    bloc = BlocProvider.of<CategoryFormBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocListener<CategoryFormBloc, CategoryFormState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              AppToast.error(responseState.message);
            } else if (responseState is Success) {
              AppToast.success('Categoría guardada correctamente');
            }
          },
          child: BlocBuilder<CategoryFormBloc, CategoryFormState>(
            builder: (context, state) {
              final r = state.response;

              return Stack(
                children: [
                  CategoryFormContent(bloc, state, category),
                  if (r is Loading)
                    const Positioned.fill(
                      child: ColoredBox(
                        color: Color(0x66000000),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
