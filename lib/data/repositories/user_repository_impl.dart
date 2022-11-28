import 'dart:math';

import 'package:holodos/core/error/exception.dart';
import 'package:holodos/data/datasources/user_remote_data_source.dart';
import 'package:holodos/domain/entities/cuisine_entity.dart';
import 'package:holodos/domain/entities/tag_entity.dart';
import 'package:holodos/domain/entities/step_entity.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  Future<Either<Failure, T>> _call<T>(Future<T> Function() callVoidFunc) async {
    try {
      final remoteObj = await callVoidFunc();
      return Right(remoteObj);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addProductToUserList(
      ProductEntity product) async {
    return await _call<void>(
        () => remoteDataSource.addProductToUserList(product));
  }

  @override
  Future<Either<Failure, void>> addRecipeToFavorites(
      RecipeEntity recipe) async {
    return await _call<void>(
        () => remoteDataSource.addRecipeToFavorites(recipe));
  }

  /*
  @override
  Future<Either<Failure, void>> commentOnComment(
      String uId, CommentEntity response, CommentEntity comment) async {
    return await _call<void>(
        () => remoteDataSource.commentOnComment(uId, response, comment));
  }
  */

  @override
  Future<Either<Failure, void>> commentOnRecipe(
      String comment, RecipeEntity recipe) async {
    return await _call<void>(
        () => remoteDataSource.commentOnRecipe(comment, recipe));
  }

  @override
  Future<Either<Failure, void>> createCurrentUser(UserEntity user) async {
    return await _call<void>(() => remoteDataSource.createCurrentUser(user));
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    return await _call<List<ProductEntity>>(
        () => remoteDataSource.getAllProducts());
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getAllRecipes(
      Map<String, dynamic>? params) async {
    return await _call<List<RecipeEntity>>(
        () => remoteDataSource.getAllRecipes(params));
  }

  @override
  Future<Either<Failure, String>> getCurrentUId() async {
    return await _call<String>(() => remoteDataSource.getCurrentUId());
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipesFromFavorites() async {
    return await _call<List<RecipeEntity>>(
        () => remoteDataSource.getRecipesFromFavorites());
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getListOfUsersProducts() async {
    return await _call<List<ProductEntity>>(
        () => remoteDataSource.getListOfUsersProducts());
  }

  @override
  Future<Either<Failure, bool>> isSignIn() async {
    return await _call<bool>(() => remoteDataSource.isSignIn());
  }

  @override
  Future<Either<Failure, void>> removeProductFromUserList(
      ProductEntity product) async {
    return await _call<void>(
        () => remoteDataSource.removeProductFromUserList(product));
  }

  @override
  Future<Either<Failure, void>> removeRecipeFromFavorites(
      RecipeEntity recipe) async {
    return await _call<void>(
        () => remoteDataSource.removeRecipeFromFavorites(recipe));
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> searchRecipesByCategories(
      List<CategoryEntity> categories) async {
    return await _call<List<RecipeEntity>>(
        () => remoteDataSource.searchRecipesByCategories(categories));
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> searchRecipesByName(
      String name) async {
    return await _call<List<RecipeEntity>>(
        () => remoteDataSource.searchRecipesByName(name));
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> searchRecipesByProducts(
      List<ProductEntity> products) async {
    return await _call<List<RecipeEntity>>(
        () => remoteDataSource.searchRecipesByProducts(products));
  }

  @override
  Future<Either<Failure, void>> shareRecipe(RecipeEntity recipe) async {
    return await _call<void>(() => remoteDataSource.shareRecipe(recipe));
  }

  @override
  Future<Either<Failure, void>> signIn(UserEntity user) async {
    return await _call<void>(() => remoteDataSource.signIn(user));
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return await _call<void>(() => remoteDataSource.signOut());
  }

  @override
  Future<Either<Failure, void>> signUp(UserEntity user) async {
    return await _call<void>(() => remoteDataSource.signUp(user));
  }

  @override
  Future<Either<Failure, void>> updateProductFromUserList(
      ProductEntity product) async {
    return await _call<void>(
        () => remoteDataSource.updateProductFromUserList(product));
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProductsByName(
      String name) async {
    return await _call<List<ProductEntity>>(
        () => remoteDataSource.searchProductsByName(name));
  }

  @override
  Future<Either<Failure, void>> resetPassword(UserEntity user) async {
    return await _call<void>(() => remoteDataSource.resetPassword(user));
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getRecipeIngredients(
      String recipeId) async {
    return await _call<List<ProductEntity>>(
        () => remoteDataSource.getRecipeIngredients(recipeId));
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getRecipeCategories(
      String recipeId) async {
    return await _call<List<CategoryEntity>>(
        () => remoteDataSource.getRecipeCategories(recipeId));
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getRecipeComments(
      String recipeId) async {
    return await _call<List<CommentEntity>>(
        () => remoteDataSource.getRecipeComments(recipeId));
  }

  @override
  Future<Either<Failure, List<StepEntity>>> getRecipeSteps(
      String recipeId) async {
    return await _call<List<StepEntity>>(
        () => remoteDataSource.getRecipeSteps(recipeId));
  }

  @override
  Future<Either<Failure, List<TagEntity>>> getRecipeTags(
      String recipeId) async {
    return await _call<List<TagEntity>>(
        () => remoteDataSource.getRecipeTags(recipeId));
  }

  @override
  Future<Either<Failure, List<CuisineEntity>>> getAllCuisines() async {
    return await _call<List<CuisineEntity>>(
        () => remoteDataSource.getAllCuisines());
  }
}
