import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/usecases/add_recipe_to_favorites.dart';
import 'package:holodos/domain/usecases/comment_on_recipe.dart';
import 'package:holodos/domain/usecases/get_all_recipes.dart';
import 'package:holodos/domain/usecases/get_recipe_by_id.dart';
import 'package:holodos/domain/usecases/get_recipes_from_favorites.dart';
import 'package:holodos/domain/usecases/remove_recipe_from_favorites.dart';

part 'recipe_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  final RemoveRecipeFromFavorites removeRecipeFromFavoritesUseCase;
  final GetRecipesFromFavorites getRecipesFromFavoritesUseCase;
  final AddRecipeToFavorites addRecipeToFavoritesUseCase;

  final GetAllRecipes getAllRecipesUseCase;

  final CommentOnRecipe commentOnRecipe;

  RecipesCubit({
    required this.removeRecipeFromFavoritesUseCase,
    required this.getRecipesFromFavoritesUseCase,
    required this.addRecipeToFavoritesUseCase,
    required this.getAllRecipesUseCase,
    required this.commentOnRecipe,
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

  Future<void> removeRecipeFromFavorites(
      {required RecipeEntity recipe, bool? setState}) async {
    emit(RecipesLoading());
    try {
      RemoveRecipeFromFavoritesParams params =
          RemoveRecipeFromFavoritesParams(recipe: recipe);
      await removeRecipeFromFavoritesUseCase(params);
      if (setState == true) {
        final failureOrRecipes = await getRecipesFromFavoritesUseCase();
        failureOrRecipes.fold((_) => emit(RecipesFailure()),
            (value) => emit(RecipesLoaded(recipes: value)));
      }
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
}

class RecipeCubit extends Cubit<RecipeState> {
  final GetRecipeById getRecipeByIdUseCase;

  RecipeCubit({
    required this.getRecipeByIdUseCase,
  }) : super(RecipeInitial());

  Future<void> getRecipeById({required String id}) async {
    emit(RecipeLoading());
    try {
      GetRecipeByIdParams params = GetRecipeByIdParams(id: id);
      final failureOrRecipe = await getRecipeByIdUseCase(params);
      failureOrRecipe.fold((_) => emit(RecipeFailure()),
          (recipe) => emit(RecipeLoaded(recipe: recipe)));
    } on SocketException catch (_) {
      emit(RecipeFailure());
    } catch (_) {
      emit(RecipeFailure());
    }
  }
}
