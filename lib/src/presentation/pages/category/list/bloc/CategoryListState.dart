import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';

class CategoryListState extends Equatable {
  final String? busqueda;
  final Resource? response;

  const CategoryListState({this.busqueda, this.response});

  CategoryListState copyWith({String? busqueda, Resource? response}) {
    return CategoryListState(
      busqueda: busqueda ?? this.busqueda,
      response: response,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [busqueda, response];
}
