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
    on<EstadoChangedProductFormEvent>(_onEstadoChanged);
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
    // 1) Arranca cargando (1 solo emit)
    emit(
      state.copyWith(
        responseCategory: Loading(),
        responseSubcategory: Loading(),
        responseProduct: event.id.isNotEmpty
            ? Loading()
            : state.responseProduct,
        formKey: formKey,
      ),
    );

    // 2) Pide categories + subcategories en paralelo
    final results = await Future.wait<Resource>([
      categoryUseCases.getCategories.run(),
      subCategoryUseCases.getSubCategories.run(),
    ]);

    final responseCategorias = results[0];
    final responseSubCategorias = results[1];

    final List<Category> listaCategories = responseCategorias is Success
        ? (responseCategorias.data as List<Category>)
        : <Category>[];

    final List<SubCategory> listaSubCategories =
        responseSubCategorias is Success
        ? (responseSubCategorias.data as List<SubCategory>)
        : <SubCategory>[];

    // 3) Si es edición, trae el producto
    Resource? responseProduct;
    Product? product;

    if (event.id.isNotEmpty) {
      responseProduct = await productUseCases.getBydId.run(event.id);
      if (responseProduct is Success) {
        product = responseProduct.data as Product;
      }
    }

    // 4) Calcula valores finales
    final String idCategory = product?.idCategory ?? '';
    final String? idSubcategory = product?.idSubcategory; // String?
    final String descripcionValue = product?.descripcion ?? '';
    final String codAlterno = product?.codAlterno ?? '';
    final int stock = product?.stock ?? 0;

    // Lista filtrada para el dropdown (si decides seguir usando responseSubcategory filtrada)
    final List<SubCategory> subsFiltradas = idCategory.isEmpty
        ? <SubCategory>[]
        : listaSubCategories.where((x) => x.idCategory == idCategory).toList();

    // 5) Emit final (1 solo emit con todo listo)
    emit(
      state.copyWith(
        // data base
        listaCategories: listaCategories,
        listaSubCategories: listaSubCategories,

        // responses
        responseCategory: responseCategorias,
        responseSubcategory: product?.id != null
            ? Success(subsFiltradas)
            : Success(
                listaSubCategories,
              ), // o Success(listaSubCategories) si quieres todas
        responseProduct: responseProduct,

        // form
        id: event.id,
        idCategory: idCategory,
        idSubcategory: idSubcategory,
        descripcion: BlocFormItem(
          value: descripcionValue,
          error: descripcionValue.isNotEmpty ? null : 'Ingrese la descripcion',
        ),
        codAlterno: codAlterno,
        stock: stock,
        imagenUrl1: product?.imagen1,
        imagenUrl2: product?.imagen2,
        formKey: formKey,
      ),
    );
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

  Future<void> _onEstadoChanged(
    EstadoChangedProductFormEvent event,
    Emitter<ProductFormState> emit,
  ) async {
    emit(state.copyWith(isActive: event.isActive, formKey: formKey));
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
      print('SELECIONO IMAGEN ${image.path}');
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
      emit(state.copyWith(file2: File(image.path), formKey: formKey));
    }
  }
}
