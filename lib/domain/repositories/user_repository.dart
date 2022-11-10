import 'package:dartz/dartz.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';

import '../../core/error/failure.dart';
import '../entities/product_entity.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, bool>> isSignIn();
  Future<Either<Failure, void>> signIn(UserEntity user);
  Future<Either<Failure, void>> signUp(UserEntity user);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, String>> getCurrentUId();
  Future<Either<Failure, void>> createCurrentUser(UserEntity user);
  Future<Either<Failure, void>> resetPassword(UserEntity user);

  Future<Either<Failure, Stream<List<ProductEntity>>>> getAllProducts();
  Future<Either<Failure, void>> addProductToUserList(ProductEntity product);
  Future<Either<Failure, void>> updateProductFromUserList(
      String uId, ProductEntity product);
  Future<Either<Failure, void>> removeProductFromUserList(
      String uId, ProductEntity product);
  Future<Either<Failure, Stream<List<ProductEntity>>>> getListOfUsersProducts(
      String uId);

  Future<Either<Failure, Stream<List<RecipeEntity>>>> getAllRecipes();
  Future<Either<Failure, void>> addRecipeToFavorites(
      String uId, RecipeEntity recipe);
  Future<Either<Failure, void>> removeRecipeFromFavorites(
      String uId, RecipeEntity recipe);
  Future<Either<Failure, Stream<List<RecipeEntity>>>> getRecipesFromFavorites(
      String uId);

  Future<Either<Failure, Stream<List<ProductEntity>>>> searchProductsByName(
      String name);

  Future<Either<Failure, Stream<List<RecipeEntity>>>> searchRecipesByName(
      String name);
  Future<Either<Failure, Stream<List<RecipeEntity>>>> searchRecipesByProducts(
      List<ProductEntity> products);
  Future<Either<Failure, Stream<List<RecipeEntity>>>> searchRecipesByCategories(
      List<CategoryEntity> categories);

  Future<Either<Failure, void>> shareRecipe(RecipeEntity recipe);
  Future<Either<Failure, void>> commentOnRecipe(
      UserEntity user, CommentEntity comment, RecipeEntity recipe);

  /*
  Future<Either<Failure, void>> commentOnComment(
      String uId, CommentEntity response, CommentEntity comment);
  */
}
