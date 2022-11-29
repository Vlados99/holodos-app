// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:holodos/core/error/failure.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/usecases/search_products_by_name.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final SearchProductsByName searchProductsByName;

  SearchProductBloc({
    required this.searchProductsByName,
  }) : super(ProductEmpty()) {
    on<SearchProductsByNameBloc>((event, emit) async {
      emit(SearchProductLoading());

      final failureOrProduct = await searchProductsByName(
          SearchProductsByNameParams(name: event.name));

      failureOrProduct.fold(
          (failure) => emit(
              SearchProductFailure(message: _mapFailureToMessage(failure))),
          (products) => emit(SearchProductLoaded(products: products)));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server Failure";
      default:
        return "Unexpected Error";
    }
  }
}
