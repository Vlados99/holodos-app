import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class CommentOnRecipe extends UseCaseWithParams<void, CommentOnRecipeParams> {
  final UserRepository repository;

  CommentOnRecipe({required this.repository});

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.commentOnRecipe(
        params.uId, params.comment, params.recipe);
  }
}

class CommentOnRecipeParams extends Equatable {
  final String uId;
  final CommentEntity comment;
  final RecipeEntity recipe;

  CommentOnRecipeParams(
      {required this.uId, required this.comment, required this.recipe});

  @override
  List<Object?> get props => [uId, comment, recipe];
}
