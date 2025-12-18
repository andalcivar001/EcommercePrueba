import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class InitHomeEvent extends HomeEvent {
  const InitHomeEvent();
}

class PageChangeHomeEvent extends HomeEvent {
  final int pageIndex;
  const PageChangeHomeEvent({required this.pageIndex});

  @override
  List<Object?> get props => [pageIndex];
}

class LogoutHomeEvent extends HomeEvent {
  const LogoutHomeEvent();
}
