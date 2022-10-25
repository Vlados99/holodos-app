import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class AddRecipeToFavorites
    extends UseCaseWithParams<void, AddRecipeToFavoritesParams> {
  final UserRepository repository;

  AddRecipeToFavorites({required this.repository});

  @override
  Future<Either<Failure, void>> call(AddRecipeToFavoritesParams params) async {
    return await repository.addRecipeToFavorites(params.uId, params.recipe);
  }
}

class AddRecipeToFavoritesParams extends Equatable {
  final String uId;
  final RecipeEntity recipe;

  AddRecipeToFavoritesParams({required this.uId, required this.recipe});

  @override
  List<Object?> get props => [uId, recipe];
}
