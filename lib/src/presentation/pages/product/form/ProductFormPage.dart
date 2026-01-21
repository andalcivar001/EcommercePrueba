import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/ProductFormContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormState.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/list/bloc/ProductListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  late ProductFormBloc? bloc;
  String? id;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _initialized) return;

      bloc = BlocProvider.of<ProductFormBloc>(context);

      final args = ModalRoute.of(context)?.settings.arguments;
      id = args is String ? args : null;

      bloc?.add(InitProductFormEvent(id: id ?? ''));

      _initialized = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    bloc?.add(ResetProductFormEvent());
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProductFormBloc>(context);

    return Scaffold(
      body: BlocListener<ProductFormBloc, ProductFormState>(
        listener: (context, state) {
          final responseState = state.response;
          final responseCategory = state.responseCategory;
          final responseSubcategory = state.responseSubcategory;
          if (responseState is Success) {
            AppToast.success('Producto guaradado correctamente');
            //state.formKey!.currentState?.reset();
            context.read<ProductListBloc>().add(InitProductListEvent());
          } else if (responseState is Error) {
            AppToast.error(
              'Error al guardar el producto ${responseState.message}',
            );
          }

          if (responseCategory is Error) {
            AppToast.error(
              'Error al obtener las cateogrías ${responseCategory.message}',
            );
          }

          if (responseSubcategory is Error) {
            AppToast.error(
              'Error al obtener las subcategorias ${responseSubcategory.message}',
            );
          }
        },
        child: BlocBuilder<ProductFormBloc, ProductFormState>(
          builder: (context, state) {
            final response = state.response;
            final responseCategory = state.responseCategory;
            final responseSubcategory = state.responseSubcategory;

            return Stack(
              children: [
                ProductFormContent(
                  bloc,
                  state,
                  responseCategory is Success
                      ? responseCategory.data as List<Category>
                      : [],
                  responseSubcategory is Success
                      ? responseSubcategory.data as List<SubCategory>
                      : [],
                ),
                if (response is Loading ||
                    responseCategory is Loading ||
                    responseSubcategory is Loading)
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
    );
  }
}
