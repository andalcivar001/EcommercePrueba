import 'package:equatable/equatable.dart';

abstract class SearchProductEvent extends Equatable {
  const SearchProductEvent();
  @override
  List<Object?> get props => [];
}

class InitSearchProductEvent extends SearchProductEvent {
  const InitSearchProductEvent();
}

class QueryChangedSearchProductEvent extends SearchProductEvent {
  final String query;
  const QueryChangedSearchProductEvent({required this.query});
  @override
  List<Object?> get props => [query];
}

class ConsultarSearchProductEvent extends SearchProductEvent {
  const ConsultarSearchProductEvent();
}

class ResetSearchProductEvent extends SearchProductEvent {
  const ResetSearchProductEvent();
}

class ErrorSearchProductEvent extends SearchProductEvent {
  const ErrorSearchProductEvent();
}
