import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:ecommerce_prueba/src/presentation/utils/BlocFormItem.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryFormEvent extends Equatable {
  const CategoryFormEvent();
  @override
  List<Object?> get props => [];
}

class InitCategoryFormEvent extends CategoryFormEvent {
  final Category? category;
  const InitCategoryFormEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class NombreChangedCategoryFormEvent extends CategoryFormEvent {
  final BlocFormItem nombre;
  const NombreChangedCategoryFormEvent({required this.nombre});
  @override
  List<Object?> get props => [nombre];
}

class DescripcionChangedCategoryFormEvent extends CategoryFormEvent {
  final BlocFormItem descripcion;
  const DescripcionChangedCategoryFormEvent({required this.descripcion});
  @override
  List<Object?> get props => [descripcion];
}

class EstadoChangedCategoryFormEvent extends CategoryFormEvent {
  final bool isActive;
  const EstadoChangedCategoryFormEvent({required this.isActive});
  @override
  List<Object?> get props => [isActive];
}

class FormSubmittedCategoryFormEvent extends CategoryFormEvent {
  const FormSubmittedCategoryFormEvent();
}

class ResetFormCategoryFormEvent extends CategoryFormEvent {
  const ResetFormCategoryFormEvent();
}
