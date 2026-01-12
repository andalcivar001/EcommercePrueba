import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/SubCategoryFormContent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/bloc/SubCategoryFormBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/bloc/SubCategoryFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/form/bloc/SubCategoryFormState.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListBloc.dart';
import 'package:ecommerce_prueba/src/presentation/pages/subcategory/list/bloc/SubCategoryListEvent.dart';
import 'package:ecommerce_prueba/src/presentation/widgets/AppToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryFormPage extends StatefulWidget {
  const SubCategoryFormPage({super.key});

  @override
  State<SubCategoryFormPage> createState() => _SubCategoryFormPageState();
}

class _SubCategoryFormPageState extends State<SubCategoryFormPage> {
  SubCategory? subcategory;
  SubCategoryFormBloc? bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc?.add(InitSubCategoryFormEvent(subCategory: subcategory));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      subcategory = ModalRoute.of(context)?.settings.arguments as SubCategory;
    }
    bloc = BlocProvider.of<SubCategoryFormBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocListener<SubCategoryFormBloc, SubCategoryFormState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              AppToast.error(responseState.message);
            } else if (responseState is Success) {
              AppToast.success('Subcategoría guardada correctamente');
              context.read<SubCategoryListBloc>().add(
                InitSubCategoryListEvent(),
              );
            }
          },
          child: BlocBuilder<SubCategoryFormBloc, SubCategoryFormState>(
            builder: (context, state) {
              final r = state.response;

              return Stack(
                children: [
                  SubCategoryFormContent(bloc, state, subcategory),

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
