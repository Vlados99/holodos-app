import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetRecipeCategories
    extends UseCaseWithParams<List<CategoryEntity>, GetRecipeCategoriesParams> {
  final UserRepository repository;

  GetRecipeCategories({required this.repository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(params) async {
    return await repository.getRecipeCategories(params.recipeId);
  }
}

class GetRecipeCategoriesParams extends Equatable {
  final String recipeId;

  const GetRecipeCategoriesParams({required this.recipeId});

  @override
  List<Object?> get props => [recipeId];
}
