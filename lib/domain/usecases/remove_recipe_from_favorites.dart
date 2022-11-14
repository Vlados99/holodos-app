import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class RemoveRecipeFromFavorites
    extends UseCaseWithParams<void, RemoveRecipeFromFavoritesParams> {
  final UserRepository repository;

  RemoveRecipeFromFavorites({required this.repository});

  @override
  Future<Either<Failure, void>> call(
      RemoveRecipeFromFavoritesParams params) async {
    return await repository.removeRecipeFromFavorites(params.recipe);
  }
}

class RemoveRecipeFromFavoritesParams extends Equatable {
  final RecipeEntity recipe;

  RemoveRecipeFromFavoritesParams({required this.recipe});

  @override
  List<Object?> get props => [recipe];
}
