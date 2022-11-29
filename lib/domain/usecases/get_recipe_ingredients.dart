import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetRecipeIngredients
    extends UseCaseWithParams<List<ProductEntity>, GetRecipeIngredientsParams> {
  final UserRepository repository;

  GetRecipeIngredients({required this.repository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(params) async {
    return await repository.getRecipeIngredients(params.recipeId);
  }
}

class GetRecipeIngredientsParams extends Equatable {
  final String recipeId;

  const GetRecipeIngredientsParams({required this.recipeId});

  @override
  List<Object?> get props => [recipeId];
}
