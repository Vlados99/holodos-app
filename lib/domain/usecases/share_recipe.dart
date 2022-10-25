import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class ShareRecipe extends UseCaseWithParams<void, ShareRecipeParams> {
  final UserRepository repository;

  ShareRecipe({required this.repository});

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.shareRecipe(params.recipe);
  }
}

class ShareRecipeParams extends Equatable {
  final RecipeEntity recipe;

  ShareRecipeParams({required this.recipe});

  @override
  List<Object?> get props => [recipe];
}
