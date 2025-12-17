import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final int? pageIndex;

  const HomeState({this.pageIndex});

  HomeState copyWith({int? pageIndex}) {
    return HomeState(pageIndex: pageIndex);
  }

  @override
  List<Object?> get props => [pageIndex];
}
