import 'package:ecommerce_prueba/src/domain/models/User.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final User? user;
  final int? pageIndex;

  const HomeState({this.pageIndex, this.user});

  HomeState copyWith({int? pageIndex, User? user}) {
    return HomeState(pageIndex: pageIndex, user: user);
  }

  @override
  List<Object?> get props => [pageIndex, user];
}
