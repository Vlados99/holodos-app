import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase.dart';
import 'package:holodos/domain/repositories/recipe_repository.dart';

import '../../core/error/failure.dart';
import '../entities/recipe_entity.dart';

class GetAllRecipes extends UseCase<List<RecipeEntity>> {
  final RecipeRepository recipeRepository;

  GetAllRecipes(this.recipeRepository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> call() async {
    return await recipeRepository.getAllRecipes();
  }
}
