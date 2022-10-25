import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class SearchRecipeByCategories extends UseCaseWithParams<
    Stream<List<RecipeEntity>>, SearchRecipeByCategoriesParams> {
  final UserRepository repository;

  SearchRecipeByCategories({required this.repository});

  @override
  Future<Either<Failure, Stream<List<RecipeEntity>>>> call(params) async {
    return await repository.searchRecipeByCategories(params.categories);
  }
}

class SearchRecipeByCategoriesParams extends Equatable {
  final List<CategoryEntity> categories;

  SearchRecipeByCategoriesParams({required this.categories});

  @override
  List<Object?> get props => [categories];
}
