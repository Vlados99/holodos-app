import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/usecases/add_recipe_to_favorites.dart';
import 'package:holodos/domain/usecases/commentOnRecipe.dart';
import 'package:holodos/domain/usecases/get_all_recipes.dart';
import 'package:holodos/domain/usecases/get_recipes_from_favorites.dart';
import 'package:holodos/domain/usecases/remove_recipe_from_favorites.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RemoveRecipeFromFavorites removeRecipeFromFavoritesUseCase;
  final GetRecipesFromFavorites getRecipesFromFavoritesUseCase;
  final AddRecipeToFavorites addRecipeToFavoritesUseCase;

  final GetAllRecipes getAllRecipesUseCase;

  final CommentOnRecipe commentOnRecipe;

  RecipeCubit({
    required this.removeRecipeFromFavoritesUseCase,
    required this.getRecipesFromFavoritesUseCase,
    required this.addRecipeToFavoritesUseCase,
    required this.getAllRecipesUseCase,
    required this.commentOnRecipe,
  }) : super(RecipeInitial());

  Future<void> addRecipeToFavorites({required RecipeEntity recipe}) async {
    try {
      AddRecipeToFavoritesParams params =
          AddRecipeToFavoritesParams(recipe: recipe);
      await addRecipeToFavoritesUseCase(params);
    } on SocketException catch (_) {
      emit(RecipeFailure());
    } catch (_) {
      emit(RecipeFailure());
    }
  }

  Future<void> removeRecipeFromFavorites({required RecipeEntity recipe}) async {
    try {
      RemoveRecipeFromFavoritesParams params =
          RemoveRecipeFromFavoritesParams(recipe: recipe);
      await removeRecipeFromFavoritesUseCase(params);
    } on SocketException catch (_) {
      emit(RecipeFailure());
    } catch (_) {
      emit(RecipeFailure());
    }
  }

  Future<void> getRecipesFromFavorites() async {
    emit(RecipeLoading());
    try {
      final recipes = await getRecipesFromFavoritesUseCase();
      recipes.fold((_) => emit(RecipeFailure()),
          (value) => emit(RecipesLoaded(recipes: value)));
    } on SocketException catch (_) {
      emit(RecipeFailure());
    } catch (_) {
      emit(RecipeFailure());
    }
  }

  Future<void> getRecipes({Map<String, dynamic>? recipeParams}) async {
    emit(RecipeLoading());
    try {
      GetAllRecipesParams params = GetAllRecipesParams(params: recipeParams);
      final recipes = await getAllRecipesUseCase(params);
      recipes.fold((_) => emit(RecipeFailure()),
          (value) => emit(RecipesLoaded(recipes: value)));
    } on SocketException catch (_) {
      emit(RecipeFailure());
    } catch (_) {
      emit(RecipeFailure());
    }
  }
}
