import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();
  @override
  List<Object?> get props => [];
}

class InitProductListEvent extends ProductListEvent {
  const InitProductListEvent();
}

class BusquedaChangedProductListEvent extends ProductListEvent {
  final String busqueda;
  const BusquedaChangedProductListEvent({required this.busqueda});
  @override
  // TODO: implement props
  List<Object?> get props => [busqueda];
}

class DeleteProductListEvent extends ProductListEvent {
  final String id;
  const DeleteProductListEvent({required this.id});
}
