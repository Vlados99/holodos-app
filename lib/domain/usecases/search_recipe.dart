import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/repositories/recipe_repository.dart';

import '../../core/error/failure.dart';
import '../entities/recipe_entity.dart';

class SearchRecipe
    extends UseCaseWithParams<List<RecipeEntity>, SearchRecipeParams> {
  final RecipeRepository recipeRepository;

  SearchRecipe(this.recipeRepository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> call(
      SearchRecipeParams params) async {
    return await recipeRepository.searchRecipe(params.query);
  }
}

class SearchRecipeParams extends Equatable {
  final String query;

  SearchRecipeParams({required this.query});
  @override
  List<Object?> get props => [query];
}
