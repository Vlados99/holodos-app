import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase.dart';

import '../../core/error/failure.dart';
import '../entities/recipe_entity.dart';
import '../repositories/user_repository.dart';

class GetAllRecipes extends UseCase<List<RecipeEntity>> {
  final UserRepository repository;

  GetAllRecipes({required this.repository});

  @override
  Future<Either<Failure, List<RecipeEntity>>> call() async {
    return await repository.getAllRecipes();
  }
}
