import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holodos/data/datasources/user_remote_data_source.dart';
import 'package:holodos/data/models/comment_model.dart';
import 'package:holodos/data/models/product_model.dart';
import 'package:holodos/data/models/recipe_model.dart';
import 'package:holodos/data/models/user_model.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/category_entity.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<void> addProductToUserList(String uId, ProductEntity product) async {
    final usersProductCollectionRef =
        firestore.collection("users").doc(uId).collection("products");
    final userProductDocId = usersProductCollectionRef.doc().id;

    await usersProductCollectionRef
        .doc(userProductDocId)
        .get()
        .then((_product) async {
      final newProduct = ProductModel(
        id: userProductDocId,
        name: product.name,
        unit: product.unit,
      ).toDocument();

      if (!_product.exists) {
        await usersProductCollectionRef.doc(userProductDocId).set(newProduct);
      } else {
        print("-----PRODUCT EXISTS, "
            "TRY TO CREATE A FEATURE TO ADD UNIT TO THE PAST UNIT-----");
      }
      return;
    });
  }

  @override
  Future<void> addRecipeToFavorites(String uId, RecipeEntity recipe) async {
    final favoriteRecipesCollectionRef =
        firestore.collection("users").doc(uId).collection("favoriteRecipes");
    final favoriteRecipeDocId = favoriteRecipesCollectionRef.doc().id;

    await favoriteRecipesCollectionRef
        .doc(favoriteRecipeDocId)
        .get()
        .then((_recipe) async {
      final newRecipe = RecipeModel(
        id: favoriteRecipeDocId,
        name: recipe.name,
        cookTime: recipe.cookTime,
        howEasy: recipe.howEasy,
        serves: recipe.serves,
        categories: recipe.categories,
        ingredients: recipe.ingredients,
        steps: recipe.steps,
      ).toDocument();

      if (!_recipe.exists) {
        await favoriteRecipesCollectionRef
            .doc(favoriteRecipeDocId)
            .set(newRecipe);
      } else {
        print("-----RECIPE EXISTS, SHOW FOR USER MESSAGE-----");
      }
      return;
    });
  }
/*
  @override
  Future<void> commentOnComment(
      String uId, CommentEntity response, CommentEntity comment) {
    // TODO: implement commentOnComment
    throw UnimplementedError();
  }*/

  @override
  Future<void> commentOnRecipe(
      UserEntity user, CommentEntity comment, RecipeEntity recipe) async {
    final recipesCommentsCollectionRef =
        firestore.collection("recipes").doc(recipe.id).collection("comments");
    final commentId = recipesCommentsCollectionRef.doc().id;

    await recipesCommentsCollectionRef
        .doc(commentId)
        .get()
        .then((_comment) async {
      final newComment = CommentModel(
        id: commentId,
        userName: user.name,
        content: comment.content,
        image: comment.image,
      ).toDocument();

      await recipesCommentsCollectionRef.doc(commentId).set(newComment);
      return;
    });
  }

  @override
  Future<void> createCurrentUser(UserEntity user) async {
    final usersCollectionRef = firestore.collection("users");
    final uId = await getCurrentUId();

    await usersCollectionRef.doc(uId).get().then((_user) async {
      final newUser = UserModel(
        uId: uId,
        status: user.status,
        password: user.password,
        email: user.email,
        name: user.name,
      ).toDocument();

      if (!_user.exists) {
        await usersCollectionRef.doc(uId).set(newUser);
      }
      return;
    });
  }

  @override
  Future<Stream<List<ProductEntity>>> getAllProducts() async {
    final productsCollectionRef = firestore.collection("products");

    return productsCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) => ProductModel.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  @override
  Future<Stream<List<RecipeEntity>>> getAllRecipes() async {
    final recipesCollectionRef = firestore.collection("recipes");

    return recipesCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) => RecipeModel.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<Stream<List<RecipeEntity>>> getRecipesFromFavorites(String uId) async {
    final usersRecipesCollectionRef =
        firestore.collection("users").doc(uId).collection("favoriteRecipes");

    return usersRecipesCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) => RecipeModel.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  @override
  Future<Stream<List<ProductEntity>>> getListOfUsersProducts(String uId) async {
    final usersProductCollectionRef =
        firestore.collection("users").doc(uId).collection("products");

    return usersProductCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) => ProductModel.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> removeProductFromUserList(
      String uId, ProductEntity product) async {
    final usersProductCollectionRef =
        firestore.collection("users").doc(uId).collection("products");

    await usersProductCollectionRef.doc(product.id).get().then((_product) {
      if (_product.exists) {
        usersProductCollectionRef.doc(product.id).delete();
      }
      return;
    });
  }

  @override
  Future<void> removeRecipeFromFavorites(
      String uId, RecipeEntity recipe) async {
    final usersFavoriteRecipesCollectionRef =
        firestore.collection("users").doc(uId).collection("favoriteRecipes");

    await usersFavoriteRecipesCollectionRef
        .doc(recipe.id)
        .get()
        .then((_recipe) {
      if (_recipe.exists) {
        usersFavoriteRecipesCollectionRef.doc(recipe.id).delete();
      }
      return;
    });
  }

  @override
  Future<Stream<List<RecipeEntity>>> searchRecipeByCategories(
      List<CategoryEntity> categories) async {
    final categoriesCollectionRef = firestore.collection("categories");
    final recipesCollectionRef = firestore.collection("recipes");

    return recipesCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) => RecipeModel.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  @override
  Future<Stream<List<RecipeEntity>>> searchRecipeByName(String name) {
    // TODO: implement searchRecipeByName
    throw UnimplementedError();
  }

  @override
  Future<Stream<List<RecipeEntity>>> searchRecipeByProducts(
      List<ProductEntity> products) {
    // TODO: implement searchRecipeByProducts
    throw UnimplementedError();
  }

  @override
  Future<void> shareRecipe(RecipeEntity recipe) {
    // TODO: implement shareRecipe
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserEntity user) async => await auth
      .signInWithEmailAndPassword(email: user.email, password: user.password);

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

  @override
  Future<void> updateProductFromUserList(
      String uId, ProductEntity product) async {
    Map<String, dynamic> productMap = {};
    final usersProductsCollectionRef =
        firestore.collection("users").doc(uId).collection("products");

    if (product.unit != null) productMap['unit'] = product.unit;

    await usersProductsCollectionRef.doc(product.id).update(productMap);
    return;
  }
}
