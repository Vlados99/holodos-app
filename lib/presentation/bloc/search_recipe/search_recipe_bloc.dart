import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';

import '../../../domain/entities/product_entity.dart';
import '../../../domain/usecases/search_recipes_by_categories.dart';
import '../../../domain/usecases/search_recipes_by_name.dart';
import '../../../domain/usecases/search_recipes_by_products.dart';

part 'search_recipe_event.dart';
part 'search_recipe_state.dart';

class SearchRecipeBloc extends Bloc<SearchRecipeEvent, SearchRecipeState> {
  final SearchRecipesByCategories searchRecipesByCategories;
  final SearchRecipesByProducts searchRecipesByProducts;
  final SearchRecipesByName searchRecipesByName;

  SearchRecipeBloc(
      {required this.searchRecipesByCategories,
      required this.searchRecipesByProducts,
      required this.searchRecipesByName})
      : super(RecipeEmpty()) {
    on<SearchRecipesByNameBloc>((event, emit) async {
      emit(SearchRecipeLoading());

      final failureOrRecipe = await searchRecipesByName(
          SearchRecipesByNameParams(name: event.name));

      failureOrRecipe.fold(
          (failure) =>
              emit(SearchRecipeFailure(message: _mapFailureToMessage(failure))),
          (recipes) => emit(SearchRecipeLoaded(recipes: recipes)));
    });

    on<SearchRecipesByCategoriesBloc>((event, emit) async {
      emit(SearchRecipeLoading());

      final failureOrRecipe = await searchRecipesByCategories(
          SearchRecipesByCategoriesParams(categories: event.categories));

      failureOrRecipe.fold(
          (failure) =>
              emit(SearchRecipeFailure(message: _mapFailureToMessage(failure))),
          (recipes) => emit(SearchRecipeLoaded(recipes: recipes)));
    });

    on<SearchRecipesByProductsBloc>((event, emit) async {
      emit(SearchRecipeLoading());

      final failureOrRecipe = await searchRecipesByProducts(
          SearchRecipesByProductsParams(products: event.products));

      failureOrRecipe.fold(
          (failure) =>
              emit(SearchRecipeFailure(message: _mapFailureToMessage(failure))),
          (recipes) => emit(SearchRecipeLoaded(recipes: recipes)));
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
