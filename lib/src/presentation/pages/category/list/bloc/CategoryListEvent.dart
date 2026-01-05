import 'package:ecommerce_prueba/src/domain/models/Category.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryListEvent extends Equatable {
  const CategoryListEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitCategoryListEvent extends CategoryListEvent {
  const InitCategoryListEvent();
}

class BusquedaChangedListEvent extends CategoryListEvent {
  final String busqueda;
  const BusquedaChangedListEvent({required this.busqueda});
  @override
  // TODO: implement props
  List<Object?> get props => [busqueda];
}
