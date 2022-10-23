import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/recipe_entity.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeEntity>>> getAllRecipes();
  Future<Either<Failure, List<RecipeEntity>>> searchRecipe(String query);
}
