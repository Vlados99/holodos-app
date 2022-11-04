import 'package:holodos/core/error/exception.dart';
import 'package:holodos/data/datasources/user_remote_data_source.dart';
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
/*
  Future<Either<Failure, void>> _callVoidFunc(
      Future<void> Function() callVoidFunc) async {
    try {
      final remoteObj = await callVoidFunc();
      return Right(remoteObj);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Stream<List<ProductEntity>>>> _callProductsFunc(
      Future<Stream<List<ProductEntity>>> Function() callProductsFunc) async {
    try {
      final remoteObj = await callProductsFunc();
      return Right(remoteObj);
    } on ServerException {
      return Left(ServerFailure());
    }
  }*/

  @override
  Future<Either<Failure, void>> addProductToUserList(
      String uId, ProductEntity product) async {
    return await _call<void>(
        () => remoteDataSource.addProductToUserList(uId, product));
  }

  @override
  Future<Either<Failure, void>> addRecipeToFavorites(
      String uId, RecipeEntity recipe) async {
    return await _call<void>(
        () => remoteDataSource.addRecipeToFavorites(uId, recipe));
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
      UserEntity user, CommentEntity comment, RecipeEntity recipe) async {
    return await _call<void>(
        () => remoteDataSource.commentOnRecipe(user, comment, recipe));
  }

  @override
  Future<Either<Failure, void>> createCurrentUser(UserEntity user) async {
    return await _call<void>(() => remoteDataSource.createCurrentUser(user));
  }

  @override
  Future<Either<Failure, Stream<List<ProductEntity>>>> getAllProducts() async {
    return await _call<Stream<List<ProductEntity>>>(
        () => remoteDataSource.getAllProducts());
  }

  @override
  Future<Either<Failure, Stream<List<RecipeEntity>>>> getAllRecipes() async {
    return await _call<Stream<List<RecipeEntity>>>(
        () => remoteDataSource.getAllRecipes());
  }

  @override
  Future<Either<Failure, String>> getCurrentUId() async {
    return await _call<String>(() => remoteDataSource.getCurrentUId());
  }

  @override
  Future<Either<Failure, Stream<List<RecipeEntity>>>> getRecipesFromFavorites(
      String uId) async {
    return await _call<Stream<List<RecipeEntity>>>(
        () => remoteDataSource.getRecipesFromFavorites(uId));
  }

  @override
  Future<Either<Failure, Stream<List<ProductEntity>>>> getListOfUsersProducts(
      String uId) async {
    return await _call<Stream<List<ProductEntity>>>(
        () => remoteDataSource.getListOfUsersProducts(uId));
  }

  @override
  Future<Either<Failure, bool>> isSignIn() async {
    return await _call<bool>(() => remoteDataSource.isSignIn());
  }

  @override
  Future<Either<Failure, void>> removeProductFromUserList(
      String uId, ProductEntity product) async {
    return await _call<void>(
        () => remoteDataSource.removeProductFromUserList(uId, product));
  }

  @override
  Future<Either<Failure, void>> removeRecipeFromFavorites(
      String uId, RecipeEntity recipe) async {
    return await _call<void>(
        () => remoteDataSource.removeRecipeFromFavorites(uId, recipe));
  }

  @override
  Future<Either<Failure, Stream<List<RecipeEntity>>>> searchRecipesByCategories(
      List<CategoryEntity> categories) async {
    return await _call<Stream<List<RecipeEntity>>>(
        () => remoteDataSource.searchRecipesByCategories(categories));
  }

  @override
  Future<Either<Failure, Stream<List<RecipeEntity>>>> searchRecipesByName(
      String name) async {
    return await _call<Stream<List<RecipeEntity>>>(
        () => remoteDataSource.searchRecipesByName(name));
  }

  @override
  Future<Either<Failure, Stream<List<RecipeEntity>>>> searchRecipesByProducts(
      List<ProductEntity> products) async {
    return await _call<Stream<List<RecipeEntity>>>(
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
      String uId, ProductEntity product) async {
    return await _call<void>(
        () => remoteDataSource.updateProductFromUserList(uId, product));
  }
}
