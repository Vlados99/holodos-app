import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetAllRecipes
    extends UseCaseWithParams<List<RecipeEntity>, GetAllRecipesParams> {
  final UserRepository repository;

  GetAllRecipes({required this.repository});

  @override
  Future<Either<Failure, List<RecipeEntity>>> call(
      GetAllRecipesParams params) async {
    return await repository.getAllRecipes(params.params);
  }
}

class GetAllRecipesParams extends Equatable {
  final Map<String, dynamic>? params;

  const GetAllRecipesParams({this.params});

  @override
  List<Object?> get props => [params];
}
