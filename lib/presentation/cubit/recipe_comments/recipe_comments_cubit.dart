import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/usecases/commentOnRecipe.dart';
import 'package:holodos/domain/usecases/get_recipe_comments.dart';

part 'recipe_comments_state.dart';

class CommentsCubit extends Cubit<CommentState> {
  final GetRecipeComments getRecipeCommentsUseCase;

  final CommentOnRecipe commentOnRecipeUseCase;

  CommentsCubit({
    required this.getRecipeCommentsUseCase,
    required this.commentOnRecipeUseCase,
  }) : super(CommentInitial());

  Future<void> getRecipeComments({required String recipeId}) async {
    emit(CommentLoading());
    try {
      GetRecipeCommentsParams params =
          GetRecipeCommentsParams(recipeId: recipeId);
      final comments = await getRecipeCommentsUseCase(params);
      comments.fold((_) => emit(CommentFailure()),
          (value) => emit(CommentsLoaded(comments: value)));
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> commentOnRecipe(
      {required String comment, required RecipeEntity recipe}) async {
    emit(CommentLoading());
    try {
      CommentOnRecipeParams params =
          CommentOnRecipeParams(comment: comment, recipe: recipe);
      final commentObj = await commentOnRecipeUseCase(params);

      GetRecipeCommentsParams recipeParams =
          GetRecipeCommentsParams(recipeId: recipe.id);
      final comments = await getRecipeCommentsUseCase(recipeParams);
      final temp = comments.getOrElse(() => []);
      commentObj.fold((_) => emit(CommentFailure()),
          (value) => emit(CommentsLoaded(comments: temp)));
    } on SocketException catch (_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }
}
