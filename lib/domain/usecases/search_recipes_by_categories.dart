import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class SearchRecipesByCategories extends UseCaseWithParams<
    Stream<List<RecipeEntity>>, SearchRecipesByCategoriesParams> {
  final UserRepository repository;

  SearchRecipesByCategories({required this.repository});

  @override
  Future<Either<Failure, Stream<List<RecipeEntity>>>> call(params) async {
    return await repository.searchRecipesByCategories(params.categories);
  }
}

class SearchRecipesByCategoriesParams extends Equatable {
  final List<CategoryEntity> categories;

  SearchRecipesByCategoriesParams({required this.categories});

  @override
  List<Object?> get props => [categories];
}
