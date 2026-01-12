import 'package:ecommerce_prueba/src/domain/models/SubCategory.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';

abstract class SubCategoryFormEvent extends Equatable {
  const SubCategoryFormEvent();
  @override
  List<Object?> get props => [];
}

class InitSubCategoryFormEvent extends SubCategoryFormEvent {
  SubCategory? subCategory;
  InitSubCategoryFormEvent({required this.subCategory});
  @override
  List<Object?> get props => [subCategory];
}

class NombreChangedSubCategoryFormEvent extends SubCategoryFormEvent {
  final BlocFormItem nombre;
  const NombreChangedSubCategoryFormEvent({required this.nombre});
  @override
  List<Object?> get props => [nombre];
}

class DescripcionChangedSubCategoryFormEvent extends SubCategoryFormEvent {
  final BlocFormItem descripcion;
  const DescripcionChangedSubCategoryFormEvent({required this.descripcion});
  @override
  List<Object?> get props => [descripcion];
}

class CategoriaChangedSubCategoryFormEvent extends SubCategoryFormEvent {
  final String categoria;
  const CategoriaChangedSubCategoryFormEvent({required this.categoria});
  @override
  List<Object?> get props => [categoria];
}

class EstadoChangedSubCategoryFormEvent extends SubCategoryFormEvent {
  final bool isActive;
  const EstadoChangedSubCategoryFormEvent({required this.isActive});
  @override
  List<Object?> get props => [isActive];
}

class SubmittedSubCategoryFormEvent extends SubCategoryFormEvent {
  const SubmittedSubCategoryFormEvent();
}
