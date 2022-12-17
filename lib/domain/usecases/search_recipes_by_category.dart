import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class SearchRecipesByCategory extends UseCaseWithParams<List<RecipeEntity>,
    SearchRecipesByCategoryParams> {
  final UserRepository repository;

  SearchRecipesByCategory({required this.repository});

  @override
  Future<Either<Failure, List<RecipeEntity>>> call(params) async {
    return await repository.searchRecipesByCategory(params.category);
  }
}

class SearchRecipesByCategoryParams extends Equatable {
  final CategoryEntity category;

  const SearchRecipesByCategoryParams({required this.category});

  @override
  List<Object?> get props => [category];
}
