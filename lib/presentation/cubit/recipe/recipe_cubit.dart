import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/usecases/add_recipe_to_favorites.dart';
import 'package:holodos/domain/usecases/get_recipes_from_favorites.dart';
import 'package:holodos/domain/usecases/remove_recipe_from_favorites.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RemoveRecipeFromFavorites removeRecipeFromFavorites;
  final GetRecipesFromFavorites getRecipesFromFavorites;
  final AddRecipeToFavorites addRecipeToFavorites;

  RecipeCubit(
      {required this.removeRecipeFromFavorites,
      required this.getRecipesFromFavorites,
      required this.addRecipeToFavorites})
      : super(RecipeInitial());

  Future<void> addRecipe(
      {required RecipeEntity recipe, required String userId}) async {
    try {
      AddRecipeToFavoritesParams params =
          AddRecipeToFavoritesParams(uId: userId, recipe: recipe);
      await addRecipeToFavorites(params);
    } on SocketException catch (_) {
      emit(RecipeFailure());
    } catch (_) {
      emit(RecipeFailure());
    }
  }

  Future<void> removeRecipe(
      {required RecipeEntity recipe, required String userId}) async {
    try {
      RemoveRecipeFromFavoritesParams params =
          RemoveRecipeFromFavoritesParams(uId: userId, recipe: recipe);
      await removeRecipeFromFavorites(params);
    } on SocketException catch (_) {
      emit(RecipeFailure());
    } catch (_) {
      emit(RecipeFailure());
    }
  }

  Future<void> getRecipes({required String userId}) async {
    emit(RecipeLoading());
    try {
      GetRecipesFromFavoritesParams params =
          GetRecipesFromFavoritesParams(uId: userId);
      final recipes = await getRecipesFromFavorites(params);
      recipes.fold(
          (_) => emit(RecipeFailure()),
          (value) => value.listen((recipes) {
                emit(RecipeLoaded(recipes: recipes));
              }));
    } on SocketException catch (_) {
      emit(RecipeFailure());
    } catch (_) {
      emit(RecipeFailure());
    }
  }
}
