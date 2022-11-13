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
      : super(RecipeEmpty());

  Stream<SearchRecipeState> mapEventToState(SearchRecipeEvent event) async* {
    if (event is SearchRecipesByNameBloc) {
      yield* _mapFetchRecipesByNameToState(event.name);
    }
    if (event is SearchRecipesByProductsBloc) {
      yield* _mapFetchRecipesByProductsToState(event.products);
    }
    if (event is SearchRecipesByCategoriesBloc) {
      yield* _mapFetchRecipesByCategoriesToState(event.categories);
    }
  }

  Stream<SearchRecipeState> _mapFetchRecipesByNameToState(String name) async* {
    yield SearchRecipeLoading();

    final failureOrRecipe =
        await searchRecipesByName(SearchRecipesByNameParams(name: name));

    yield failureOrRecipe.fold(
        (_failure) =>
            SearchRecipeError(message: _mapFailureToMessage(_failure)),
        (_recipes) => SearchRecipeLoaded(recipes: _recipes));
  }

  Stream<SearchRecipeState> _mapFetchRecipesByProductsToState(
      List<ProductEntity> products) async* {
    yield SearchRecipeLoading();

    final failureOrRecipe = await searchRecipesByProducts(
        SearchRecipesByProductsParams(products: products));

    yield failureOrRecipe.fold(
        (_failure) =>
            SearchRecipeError(message: _mapFailureToMessage(_failure)),
        (_recipes) => SearchRecipeLoaded(recipes: _recipes));
  }

  Stream<SearchRecipeState> _mapFetchRecipesByCategoriesToState(
      List<CategoryEntity> categories) async* {
    yield SearchRecipeLoading();

    final failureOrRecipe = await searchRecipesByCategories(
        SearchRecipesByCategoriesParams(categories: categories));

    yield failureOrRecipe.fold(
        (_failure) =>
            SearchRecipeError(message: _mapFailureToMessage(_failure)),
        (_recipes) => SearchRecipeLoaded(recipes: _recipes));
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
