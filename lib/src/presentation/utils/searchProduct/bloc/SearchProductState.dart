import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SearchProductState extends Equatable {
  final String query;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const SearchProductState({this.query = '', this.response, this.formKey});

  SearchProductState copyWith({
    String? query,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }) {
    return SearchProductState(
      query: query ?? this.query,
      response: response ?? this.response,
      formKey: formKey,
    );
  }

  @override
  List<Object?> get props => [query, response];
}
