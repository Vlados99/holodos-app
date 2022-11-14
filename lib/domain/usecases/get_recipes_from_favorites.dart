import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetRecipesFromFavorites extends UseCase<List<RecipeEntity>> {
  final UserRepository repository;

  GetRecipesFromFavorites({required this.repository});

  @override
  Future<Either<Failure, List<RecipeEntity>>> call() async {
    return await repository.getRecipesFromFavorites();
  }
}
