import 'package:equatable/equatable.dart';

abstract class SubCategoryListEvent extends Equatable {
  const SubCategoryListEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitSubCategoryListEvent extends SubCategoryListEvent {
  const InitSubCategoryListEvent();
}

class BusquedaChangedSubCategoryListEvent extends SubCategoryListEvent {
  final String busqueda;
  const BusquedaChangedSubCategoryListEvent({required this.busqueda});
  @override
  List<Object?> get props => [busqueda];
}

class DeletedSubCategoryListEvent extends SubCategoryListEvent {
  const DeletedSubCategoryListEvent();
}
