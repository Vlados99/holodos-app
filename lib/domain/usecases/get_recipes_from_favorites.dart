import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetRecipesFromFavorites extends UseCaseWithParams<List<RecipeEntity>,
    GetRecipesFromFavoritesParams> {
  final UserRepository repository;

  GetRecipesFromFavorites({required this.repository});

  @override
  Future<Either<Failure, List<RecipeEntity>>> call(params) async {
    return await repository.getRecipesFromFavorites(params.uId);
  }
}

class GetRecipesFromFavoritesParams extends Equatable {
  final String uId;

  GetRecipesFromFavoritesParams({required this.uId});

  @override
  List<Object?> get props => [uId];
}
