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

  Future<Stream<List<ProductEntity>>> getAllProducts();
  Future<void> addProductToUserList(ProductEntity product);
  Future<void> updateProductFromUserList(String uId, ProductEntity product);
  Future<void> removeProductFromUserList(String uId, ProductEntity product);
  Future<Stream<List<ProductEntity>>> getListOfUsersProducts(String uId);

  Future<Stream<List<RecipeEntity>>> getAllRecipes();
  Future<void> addRecipeToFavorites(String uId, RecipeEntity recipe);
  Future<void> removeRecipeFromFavorites(String uId, RecipeEntity recipe);
  Future<Stream<List<RecipeEntity>>> getRecipesFromFavorites(String uId);

  Future<Stream<List<ProductEntity>>> searchProductsByName(String name);

  Future<Stream<List<RecipeEntity>>> searchRecipesByName(String name);
  Future<Stream<List<RecipeEntity>>> searchRecipesByProducts(
      List<ProductEntity> products);
  Future<Stream<List<RecipeEntity>>> searchRecipesByCategories(
      List<CategoryEntity> categories);

  Future<void> shareRecipe(RecipeEntity recipe);
  Future<void> commentOnRecipe(
      UserEntity user, CommentEntity comment, RecipeEntity recipe);
  /*
  Future<void> commentOnComment(
      String uId, CommentEntity response, CommentEntity comment);*/
}
