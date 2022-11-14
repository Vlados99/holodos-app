import '../../domain/entities/category_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/recipe_entity.dart';
import '../../domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> createCurrentUser(UserEntity user);
  Future<void> resetPassword(UserEntity user);

  Future<List<ProductEntity>> getAllProducts();
  Future<void> addProductToUserList(ProductEntity product);
  Future<void> updateProductFromUserList(ProductEntity product);
  Future<void> removeProductFromUserList(ProductEntity product);
  Future<List<ProductEntity>> getListOfUsersProducts();

  Future<List<RecipeEntity>> getAllRecipes();
  Future<void> addRecipeToFavorites(RecipeEntity recipe);
  Future<void> removeRecipeFromFavorites(RecipeEntity recipe);
  Future<List<RecipeEntity>> getRecipesFromFavorites();

  Future<List<ProductEntity>> searchProductsByName(String name);

  Future<List<RecipeEntity>> searchRecipesByName(String name);
  Future<List<RecipeEntity>> searchRecipesByProducts(
      List<ProductEntity> products);
  Future<List<RecipeEntity>> searchRecipesByCategories(
      List<CategoryEntity> categories);

  Future<void> shareRecipe(RecipeEntity recipe);
  Future<void> commentOnRecipe(
      UserEntity user, CommentEntity comment, RecipeEntity recipe);
  /*
  Future<void> commentOnComment(
      String uId, CommentEntity response, CommentEntity comment);*/
}
