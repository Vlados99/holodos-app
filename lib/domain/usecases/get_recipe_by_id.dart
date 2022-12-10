import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetRecipeById
    extends UseCaseWithParams<RecipeEntity, GetRecipeByIdParams> {
  final UserRepository repository;

  GetRecipeById({required this.repository});

  @override
  Future<Either<Failure, RecipeEntity>> call(params) async {
    return await repository.getRecipeById(params.id);
  }
}

class GetRecipeByIdParams extends Equatable {
  final String id;

  const GetRecipeByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}
