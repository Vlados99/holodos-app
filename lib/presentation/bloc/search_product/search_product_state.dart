part of 'search_product_bloc.dart';

abstract class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object?> get props => [];
}

class ProductEmpty extends SearchProductState {}

class SearchProductLoading extends SearchProductState {}

class SearchProductLoaded extends SearchProductState {
  final List<ProductEntity> products;

  const SearchProductLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class SearchProductFailure extends SearchProductState {
  final String message;

  const SearchProductFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
