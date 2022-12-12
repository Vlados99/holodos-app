import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/usecases/add_recipe_to_favorites.dart';
import 'package:holodos/domain/usecases/comment_on_recipe.dart';
import 'package:holodos/domain/usecases/get_all_recipes.dart';
import 'package:holodos/domain/usecases/get_recipe_by_id.dart';
import 'package:holodos/domain/usecases/get_recipes_from_favorites.dart';
import 'package:holodos/domain/usecases/remove_recipe_from_favorites.dart';
import 'package:holodos/domain/usecases/search_recipes_by_categories.dart';
import 'package:holodos/domain/usecases/search_recipes_by_products.dart';

part 'recipe_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  final RemoveRecipeFromFavorites removeRecipeFromFavoritesUseCase;
  final GetRecipesFromFavorites getRecipesFromFavoritesUseCase;
  final AddRecipeToFavorites addRecipeToFavoritesUseCase;

  final SearchRecipesByCategory searchRecipesByCategoriesUseCase;
  final SearchRecipesByProducts searchRecipesByProductsUseCase;

  final GetAllRecipes getAllRecipesUseCase;
  final GetRecipeById getRecipeByIdUseCase;

  final CommentOnRecipe commentOnRecipe;

  RecipesCubit({
    required this.removeRecipeFromFavoritesUseCase,
    required this.getRecipesFromFavoritesUseCase,
    required this.addRecipeToFavoritesUseCase,
    required this.getAllRecipesUseCase,
    required this.getRecipeByIdUseCase,
    required this.commentOnRecipe,
    required this.searchRecipesByCategoriesUseCase,
    required this.searchRecipesByProductsUseCase,
  }) : super(RecipesInitial());

  Future<void> addRecipeToFavorites({required RecipeEntity recipe}) async {
    try {
      AddRecipeToFavoritesParams params =
          AddRecipeToFavoritesParams(recipe: recipe);
      await addRecipeToFavoritesUseCase(params);
    } on SocketException catch (_) {
      emit(RecipesFailure());
    } catch (_) {
      emit(RecipesFailure());
    }
  }

  Future<void> removeRecipeFromFavorites({required RecipeEntity recipe}) async {
    try {
      RemoveRecipeFromFavoritesParams params =
          RemoveRecipeFromFavoritesParams(recipe: recipe);
      await removeRecipeFromFavoritesUseCase(params);
    } on SocketException catch (_) {
      emit(RecipesFailure());
    } catch (_) {
      emit(RecipesFailure());
    }
  }

  Future<void> getRecipesFromFavorites() async {
    emit(RecipesLoading());
    try {
      final failureOrRecipes = await getRecipesFromFavoritesUseCase();
      failureOrRecipes.fold((_) => emit(RecipesFailure()),
          (value) => emit(RecipesLoaded(recipes: value)));
    } on SocketException catch (_) {
      emit(RecipesFailure());
    } catch (_) {
      emit(RecipesFailure());
    }
  }

  Future<void> getRecipes({Map<String, dynamic>? recipeParams}) async {
    emit(RecipesLoading());
    try {
      GetAllRecipesParams params = GetAllRecipesParams(params: recipeParams);
      final failureOrRecipes = await getAllRecipesUseCase(params);
      failureOrRecipes.fold((_) => emit(RecipesFailure()), (recipes) {
        emit(RecipesLoaded(recipes: recipes));
      });
    } on SocketException catch (_) {
      emit(RecipesFailure());
    } catch (_) {
      emit(RecipesFailure());
    }
  }

  Future<void> getRecipeById({required String id}) async {
    emit(RecipesLoading());
    try {
      GetRecipeByIdParams params = GetRecipeByIdParams(id: id);
      final failureOrRecipe = await getRecipeByIdUseCase(params);
      failureOrRecipe.fold((_) => emit(RecipesFailure()),
          (recipe) => emit(RecipeLoaded(recipe: recipe)));
    } on SocketException catch (_) {
      emit(RecipesFailure());
    } catch (_) {
      emit(RecipesFailure());
    }
  }

  Future<void> update({required String name, String? id}) async {
    if (name == PageConst.recipesPage) {
      getRecipes();
    }
    if (name == PageConst.favoriteRecipesPage) {
      getRecipesFromFavorites();
    }
    if (name == PageConst.recipePage) {
      getRecipeById(id: id!);
    }
  }

  Future<void> searchRecipesByCategories(
      {required CategoryEntity category}) async {
    emit(RecipesLoading());
    try {
      SearchRecipesByCategoryParams params =
          SearchRecipesByCategoryParams(category: category);
      final failureOrRecipe = await searchRecipesByCategoriesUseCase(params);
      failureOrRecipe.fold((_) => emit(RecipesFailure()),
          (recipes) => emit(RecipesLoaded(recipes: recipes)));
    } on SocketException catch (_) {
      emit(RecipesFailure());
    } catch (_) {
      emit(RecipesFailure());
    }
  }

  Future<void> searchRecipesByProducts({required List<String> products}) async {
    emit(RecipesLoading());
    try {
      SearchRecipesByProductsParams params =
          SearchRecipesByProductsParams(products: products);
      final failureOrRecipe = await searchRecipesByProductsUseCase(params);
      failureOrRecipe.fold((_) => emit(RecipesFailure()),
          (recipes) => emit(RecipesLoaded(recipes: recipes)));
    } on SocketException catch (_) {
      emit(RecipesFailure());
    } catch (_) {
      emit(RecipesFailure());
    }
  }
}
