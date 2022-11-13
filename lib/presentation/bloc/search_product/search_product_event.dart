part of 'search_product_bloc.dart';

abstract class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends SearchProductEvent {}

class SearchProductsByNameBloc extends SearchProductEvent {
  final String name;

  SearchProductsByNameBloc(this.name);
}
