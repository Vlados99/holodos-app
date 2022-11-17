import 'package:dartz/dartz.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetAllRecipes extends UseCase<List<RecipeEntity>> {
  final UserRepository repository;

  GetAllRecipes({required this.repository});

  @override
  Future<Either<Failure, List<RecipeEntity>>> call() async {
    return await repository.getAllRecipes();
  }
}
