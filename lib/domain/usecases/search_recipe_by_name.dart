import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class SearchRecipeByName extends UseCaseWithParams<Stream<List<RecipeEntity>>,
    SearchRecipeByNameParams> {
  final UserRepository repository;

  SearchRecipeByName({required this.repository});

  @override
  Future<Either<Failure, Stream<List<RecipeEntity>>>> call(params) async {
    return await repository.searchRecipeByName(params.name);
  }
}

class SearchRecipeByNameParams extends Equatable {
  final String name;

  SearchRecipeByNameParams({required this.name});

  @override
  List<Object?> get props => [name];
}
