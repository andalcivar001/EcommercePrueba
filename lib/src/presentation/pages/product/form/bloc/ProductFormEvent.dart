import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';

abstract class ProductFormEvent extends Equatable {
  const ProductFormEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitProductFormEvent extends ProductFormEvent {
  final String id;
  const InitProductFormEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class DescripcionChangedProductFormEvent extends ProductFormEvent {
  final BlocFormItem descripcion;
  const DescripcionChangedProductFormEvent({required this.descripcion});
  @override
  List<Object?> get props => [descripcion];
}

class CodAlternoChangedProductFormEvent extends ProductFormEvent {
  final String codAlterno;
  const CodAlternoChangedProductFormEvent({required this.codAlterno});
  @override
  List<Object?> get props => [codAlterno];
}

class StockChangedProductFormEvent extends ProductFormEvent {
  final int stock;
  const StockChangedProductFormEvent({required this.stock});
  @override
  List<Object?> get props => [stock];
}

class CategoryChangedProductFormEvent extends ProductFormEvent {
  final String idCategory;
  const CategoryChangedProductFormEvent({required this.idCategory});
  @override
  List<Object?> get props => [idCategory];
}

class SubcategoryChangedProductFormEvent extends ProductFormEvent {
  final String idSubcategory;
  const SubcategoryChangedProductFormEvent({required this.idSubcategory});
  @override
  List<Object?> get props => [idSubcategory];
}

class EstadoChangedProductFormEvent extends ProductFormEvent {
  final bool isActive;
  const EstadoChangedProductFormEvent({required this.isActive});
  @override
  List<Object?> get props => [isActive];
}

class PickImageProductFormEvent1 extends ProductFormEvent {
  const PickImageProductFormEvent1();
}

class TakePhotoProductFormEvent1 extends ProductFormEvent {
  const TakePhotoProductFormEvent1();
}

class PickImageProductFormEvent2 extends ProductFormEvent {
  const PickImageProductFormEvent2();
}

class TakePhotoProductFormEvent2 extends ProductFormEvent {
  const TakePhotoProductFormEvent2();
}

class SubmittedProductFormEvent extends ProductFormEvent {
  const SubmittedProductFormEvent();
}

class ResetProductFormEvent extends ProductFormEvent {
  const ResetProductFormEvent();
}
