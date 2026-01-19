import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/ProductFormContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormState.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  ProductFormBloc? bloc;
  String? id;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc?.add(InitProductFormEvent(id: id ?? ''));
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProductFormBloc>(context);
    if (ModalRoute.of(context)?.settings.arguments != null) {
      id = ModalRoute.of(context)?.settings.arguments as String;
    }

    return Scaffold(
      body: BlocListener<ProductFormBloc, ProductFormState>(
        listener: (context, state) {
          final responseState = state.response;
          final responseCategory = state.responseCategory;
          final responseSubcategory = state.responseSubcategory;
          if (responseState is Success) {
            AppToast.success('Producto guaradado correctamente');
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

            return Stack(children: [ProductFormContent()]);
          },
        ),
      ),
    );
  }
}
