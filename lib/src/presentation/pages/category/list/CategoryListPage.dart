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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc?.add(InitCategoryListEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<CategoryListBloc>(context);
    return Scaffold(
      body: BlocListener<CategoryListBloc, CategoryListState>(
        listener: (context, state) {
          final responseState = state.response;
          print('responseState $responseState');
          if (responseState is Success) {
            _bloc?.add(InitCategoryListEvent());
          }
          if (responseState is Error) {
            AppToast.error(responseState.message);
          }
        },
        child: BlocBuilder<CategoryListBloc, CategoryListState>(
          builder: (context, state) {
            final response = state.response;
            print('RESPONSE $response');
            if (response is Success) {
              List<Category> categories = response.data as List<Category>;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryListItem(_bloc, categories[index]);
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
