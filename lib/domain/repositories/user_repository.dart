import 'package:dartz/dartz.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/cuisine_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/entities/step_entity.dart';
import 'package:holodos/domain/entities/tag_entity.dart';

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

  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, void>> addProductToUserList(ProductEntity product);
  Future<Either<Failure, void>> updateProductFromUserList(
      ProductEntity product);
  Future<Either<Failure, void>> removeProductFromUserList(
      ProductEntity product);
  Future<Either<Failure, List<ProductEntity>>> getListOfUsersProducts();

  Future<Either<Failure, List<RecipeEntity>>> getAllRecipes(
      Map<String, dynamic>? params);
  Future<Either<Failure, List<ProductEntity>>> getRecipeIngredients(
      String recipeId);
  Future<Either<Failure, List<CategoryEntity>>> getRecipeCategories(
      String recipeId);
  Future<Either<Failure, List<CommentEntity>>> getRecipeComments(
      String recipeId);
  Future<Either<Failure, List<StepEntity>>> getRecipeSteps(String recipeId);
  Future<Either<Failure, List<TagEntity>>> getRecipeTags(String recipeId);
  Future<Either<Failure, void>> addRecipeToFavorites(RecipeEntity recipe);
  Future<Either<Failure, void>> removeRecipeFromFavorites(RecipeEntity recipe);
  Future<Either<Failure, List<RecipeEntity>>> getRecipesFromFavorites();

  Future<Either<Failure, List<CuisineEntity>>> getAllCuisines();

  Future<Either<Failure, List<ProductEntity>>> searchProductsByName(
      String name);

  Future<Either<Failure, List<RecipeEntity>>> searchRecipesByName(String name);
  Future<Either<Failure, List<RecipeEntity>>> searchRecipesByProducts(
      List<ProductEntity> products);
  Future<Either<Failure, List<RecipeEntity>>> searchRecipesByCategories(
      List<CategoryEntity> categories);

  Future<Either<Failure, void>> shareRecipe(RecipeEntity recipe);
  Future<Either<Failure, void>> commentOnRecipe(
      UserEntity user, CommentEntity comment, RecipeEntity recipe);

  /*
  Future<Either<Failure, void>> commentOnComment(
      String uId, CommentEntity response, CommentEntity comment);
  */
}
