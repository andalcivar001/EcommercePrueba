import 'dart:io';

import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/domain/models/Product.dart';
import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Category/CategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/Product/ProductUseCases.dart';
import 'package:ecommerce_prueba/src/domain/useCases/SubCategory/SubCategoryUseCases.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormEvent.dart';
import 'package:ecommerce_prueba/src/presentation/pages/product/form/bloc/ProductFormState.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  ProductUseCases productUseCases;
  CategoryUseCases categoryUseCases;
  SubCategoryUseCases subCategoryUseCases;
  ProductFormBloc(
    this.productUseCases,
    this.categoryUseCases,
    this.subCategoryUseCases,
  ) : super(ProductFormState()) {
    on<InitProductFormEvent>(_onInit);
    on<DescripcionChangedProductFormEvent>(_onDescripcionChanged);
    on<CodAlternoChangedProductFormEvent>(_onCodAlternoChanged);
    on<StockChangedProductFormEvent>(_onStockChanged);
    on<CategoryChangedProductFormEvent>(_onCategoryChanged);
    on<SubcategoryChangedProductFormEvent>(_onSubcategoryChanged);
    on<PickImageProductFormEvent1>(_onPickImage1);
    on<TakePhotoProductFormEvent1>(_onTakePhoto1);
    on<PickImageProductFormEvent2>(_onPickImage2);
    on<TakePhotoProductFormEvent2>(_onTakePhoto2);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInit(
    InitProductFormEvent event,
    Emitter<ProductFormState> emit,
  ) async {
    List<Category> listaCategory = const [];
    List<SubCategory> listaSubcategorias = const [];

    emit(state.copyWith(responseCategory: Loading(), formKey: formKey));
    final Resource responseCategorias = await categoryUseCases.getCategories
        .run();

    if (responseCategorias is Success) {
      listaCategory = responseCategorias.data;
    }

    emit(
      state.copyWith(
        responseCategory: responseCategorias,
        listaCategorias: listaCategory,
        formKey: formKey,
      ),
    );

    emit(state.copyWith(responseSubcategory: Loading(), formKey: formKey));

    final Resource responseSubCategorias = await subCategoryUseCases
        .getSubCategories
        .run();

    if (responseSubCategorias is Success) {
      listaSubcategorias = responseSubCategorias.data;
    }

    emit(
      state.copyWith(
        responseSubcategory: responseSubCategorias,
        listaSubcategorias: listaSubcategorias,
        formKey: formKey,
      ),
    );

    if (event.id.isNotEmpty) {
      emit(state.copyWith(response: Loading(), formKey: formKey));
      Resource response;
      Product product;
      response = await productUseCases.getBydId.run(event.id);
      if (response is Success) {
        product = response.data as Product;
      }

      String descripcion = product.descripcion;

      emit(
        state.copyWith(
          response: response,
          product: product,
          id: event.id,
          descripcion: BlocFormItem(
            value: descripcion,
            error: descripcion.isNotEmpty ? null : 'Ingrese la descripcion',
          ),
        ),
      );
    }
  }

  Future<void> _onDescripcionChanged(
    DescripcionChangedProductFormEvent event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(
      state.copyWith(
        descripcion: BlocFormItem(
          value: event.descripcion.value,
          error: event.descripcion.value.isNotEmpty
              ? null
              : 'Ingrese la descripcion',
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onCodAlternoChanged(
    CodAlternoChangedProductFormEvent event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(codAlterno: event.codAlterno, formKey: formKey));
  }

  Future<void> _onStockChanged(
    StockChangedProductFormEvent event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(stock: event.stock, formKey: formKey));
  }

  Future<void> _onCategoryChanged(
    CategoryChangedProductFormEvent event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(
      state.copyWith(
        idCategory: event.idCategory,
        idSubcategory: null,
        formKey: formKey,
      ),
    );
  }

  Future<void> _onSubcategoryChanged(
    SubcategoryChangedProductFormEvent event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(idSubcategory: event.idSubcategory, formKey: formKey));
  }

  Future<void> _onPickImage1(
    PickImageProductFormEvent1 event,
    Emitter<ProductFormState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(file1: File(image.path), formKey: formKey));
    }
  }

  Future<void> _onTakePhoto1(
    TakePhotoProductFormEvent1 event,
    Emitter<ProductFormState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(state.copyWith(file1: File(image.path), formKey: formKey));
    }
  }

  Future<void> _onPickImage2(
    PickImageProductFormEvent2 event,
    Emitter<ProductFormState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(file2: File(image.path), formKey: formKey));
    }
  }

  Future<void> _onTakePhoto2(
    TakePhotoProductFormEvent2 event,
    Emitter<ProductFormState> emit,
  ) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(state.copyWith(file1: File(image.path), formKey: formKey));
    }
  }
}
