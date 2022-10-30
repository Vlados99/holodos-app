import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class SearchRecipesByProducts extends UseCaseWithParams<
    Stream<List<RecipeEntity>>, SearchRecipesByProductsParams> {
  final UserRepository repository;

  SearchRecipesByProducts({required this.repository});

  @override
  Future<Either<Failure, Stream<List<RecipeEntity>>>> call(params) async {
    return await repository.searchRecipesByProducts(params.products);
  }
}

class SearchRecipesByProductsParams extends Equatable {
  final List<ProductEntity> products;

  SearchRecipesByProductsParams({required this.products});

  @override
  List<Object?> get props => [products];
}
