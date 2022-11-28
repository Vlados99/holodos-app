import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:holodos/data/datasources/user_remote_data_source.dart';
import 'package:holodos/data/models/category_model.dart';
import 'package:holodos/data/models/comment_model.dart';
import 'package:holodos/data/models/cuisine_model.dart';
import 'package:holodos/data/models/product_model.dart';
import 'package:holodos/data/models/recipe_model.dart';
import 'package:holodos/data/models/step_model.dart';
import 'package:holodos/data/models/tag_model.dart';
import 'package:holodos/data/models/user_model.dart';
import 'package:holodos/domain/entities/cuisine_entity.dart';
import 'package:holodos/domain/entities/tag_entity.dart';
import 'package:holodos/domain/entities/step_entity.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/category_entity.dart';

enum RecipeQuery {
  main,
  complexity,
  cookTimeLess,
  cookTimeGreater,
  cuisines,
  serves,
  servesGreater,
}

extension on Query<Map<String, dynamic>> {
  Query<Map<String, dynamic>> queryBy(
      RecipeQuery query, Map<String, dynamic> params) {
    switch (query) {
      case RecipeQuery.main:
        return where("name", isEqualTo: null);

      case RecipeQuery.complexity:
        return where("complexity", isEqualTo: params["complexity"]);

      case RecipeQuery.cookTimeLess:
        return where("cookTime", isLessThanOrEqualTo: params["cookTime"]);

      case RecipeQuery.cookTimeGreater:
        return where("cookTime", isGreaterThan: params["cookTime"]);

      case RecipeQuery.cuisines:
        return where("cuisines", isEqualTo: params["cuisines"]);

      case RecipeQuery.serves:
        return where("serves", isEqualTo: params["serves"]);

      case RecipeQuery.servesGreater:
        return where("serves", isGreaterThanOrEqualTo: params["serves"]);
    }
  }
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.auth, required this.firestore});

  Future<bool> _productExists(ProductEntity product) async {
    final uId = await getCurrentUId();
    final usersProductCollectionRef =
        firestore.collection("users").doc(uId).collection("products");

    List<dynamic> existsProduct =
        await _getExistsProduct(usersProductCollectionRef, product);
    if (existsProduct.isEmpty) {
      return true;
    }
    return existsProduct.contains(product.name) ? true : false;
  }

  Future<List<dynamic>> _getExistsProduct(
      CollectionReference<Map<String, dynamic>> usersProductCollectionRef,
      ProductEntity product) async {
    final existsProduct = await usersProductCollectionRef
        .where("name", isEqualTo: product.name)
        .get()
        .then((querySnapshot) =>
            querySnapshot.docs.map((e) => e.data()).toList());
    return existsProduct;
  }

  Future<void> _createAndAddProduct(
      ProductEntity product,
      CollectionReference<Map<String, dynamic>> usersProductCollectionRef,
      String userProductDocId) async {
    final newProduct = ProductModel(
      id: userProductDocId,
      name: product.name,
      unit: product.unit,
    ).toDocument();

    await usersProductCollectionRef.doc(userProductDocId).set(newProduct);
  }

  Future<void> _updateProductUnit(
      CollectionReference<Map<String, dynamic>> usersProductCollectionRef,
      ProductEntity product) async {
    final existsProduct =
        await _getExistsProduct(usersProductCollectionRef, product);

    Map<String, dynamic> unit = {
      "unit": (int.parse(existsProduct[0]["unit"]) + int.parse(product.unit!))
          .toString()
    };
    usersProductCollectionRef.doc(existsProduct[0]["id"]).update(unit);
  }

  @override
  Future<void> addProductToUserList(ProductEntity product) async {
    final uId = await getCurrentUId();
    final usersProductCollectionRef =
        firestore.collection("users").doc(uId).collection("products");
    final userProductDocId = usersProductCollectionRef.doc().id;

    await usersProductCollectionRef
        .doc(userProductDocId)
        .get()
        .then((_product) async {
      if (await _productExists(product)) {
        await _createAndAddProduct(
            product, usersProductCollectionRef, userProductDocId);
      } else {
        await _updateProductUnit(usersProductCollectionRef, product);
      }
      return;
    });
  }

  @override
  Future<void> addRecipeToFavorites(RecipeEntity recipe) async {
    final uId = await getCurrentUId();
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
        cuisines: recipe.cuisines,
        cookTime: recipe.cookTime,
        complexity: recipe.complexity,
        serves: recipe.serves,
        imageLocation: recipe.imageLocation,
        description: recipe.description,
        categories: recipe.categories,
        ingredients: recipe.ingredients,
        steps: recipe.steps,
        comments: recipe.comments,
        tags: recipe.tags,
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
  Future<void> commentOnRecipe(String comment, RecipeEntity recipe) async {
    final String uId = await getCurrentUId();

    final user =
        await firestore.collection("users").doc(uId).get().then((value) {
      return value.data()!["name"];
    });

    final recipesCommentsCollectionRef =
        firestore.collection("recipes").doc(recipe.id).collection("comments");
    final commentId = recipesCommentsCollectionRef.doc().id;

    await recipesCommentsCollectionRef
        .doc(commentId)
        .get()
        .then((_comment) async {
      final newComment = CommentModel(
        id: commentId,
        userName: user,
        comment: comment,
        date: Timestamp.fromDate(DateTime.now()),
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
      var newUser = UserModel(
        password: user.password,
        email: user.email,
        name: user.name,
      ).createUser();

      if (!_user.exists) {
        await usersCollectionRef.doc(uId).set(newUser);
      }
      return;
    });
  }

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    final productsCollectionRef = firestore.collection("products");

    QuerySnapshot querySnapshot =
        await productsCollectionRef.orderBy("name").get();

    return querySnapshot.docs
        .map((doc) => ProductModel.fromSnapshot(doc))
        .toList();
  }

  @override
  Future<List<ProductEntity>> getRecipeIngredients(String recipeId) async {
    final ingredientsRef =
        firestore.collection("recipes").doc(recipeId).collection("ingredients");

    QuerySnapshot querySnapshot = await ingredientsRef.get();

    return querySnapshot.docs.map((doc) {
      return ProductModel.fromSnapshot(doc);
    }).toList();
  }

  @override
  Future<List<CategoryEntity>> getRecipeCategories(String recipeId) async {
    final ingredientsRef =
        firestore.collection("recipes").doc(recipeId).collection("categories");

    QuerySnapshot querySnapshot = await ingredientsRef.get();

    return querySnapshot.docs.map((doc) {
      return CategoryModel.fromSnapshot(doc);
    }).toList();
  }

  @override
  Future<List<CommentEntity>> getRecipeComments(String recipeId) async {
    final ingredientsRef =
        firestore.collection("recipes").doc(recipeId).collection("comments");

    QuerySnapshot querySnapshot =
        await ingredientsRef.orderBy("date", descending: true).get();

    return querySnapshot.docs.map((doc) {
      return CommentModel.fromSnapshot(doc);
    }).toList();
  }

  @override
  Future<List<StepEntity>> getRecipeSteps(String recipeId) async {
    final ingredientsRef =
        firestore.collection("recipes").doc(recipeId).collection("steps");

    QuerySnapshot querySnapshot = await ingredientsRef.orderBy("number").get();

    return querySnapshot.docs.map((doc) {
      return StepModel.fromSnapshot(doc);
    }).toList();
  }

  @override
  Future<List<TagEntity>> getRecipeTags(String recipeId) async {
    final ingredientsRef =
        firestore.collection("recipes").doc(recipeId).collection("tags");

    QuerySnapshot querySnapshot = await ingredientsRef.get();

    return querySnapshot.docs.map((doc) {
      return TagModel.fromSnapshot(doc);
    }).toList();
  }

  @override
  Future<List<RecipeEntity>> getAllRecipes(Map<String, dynamic>? params) async {
    final recipesCollectionRef = firestore.collection("recipes");

    QuerySnapshot querySnapshot;
    if (params == null || params.isEmpty) {
      querySnapshot = await recipesCollectionRef.orderBy("name").get();
    } else {
      RecipeQuery complexityQuery = RecipeQuery.main;
      RecipeQuery cookTimeQuery = RecipeQuery.main;
      RecipeQuery servesQuery = RecipeQuery.main;
      RecipeQuery cuisinesQuery = RecipeQuery.main;

      if (params.containsKey("complexity") && params["complexity"] != null) {
        complexityQuery = RecipeQuery.complexity;
      }
      if (params.containsKey("cookTime") &&
          params.containsKey("cookTimeSymbol") &&
          params["cookTime"] != null &&
          params["cookTimeSymbol"] != null) {
        if (params["cookTimeSymbol"] == "<") {
          cookTimeQuery = RecipeQuery.cookTimeLess;
        }
        if (params["cookTimeSymbol"] == ">") {
          cookTimeQuery = RecipeQuery.cookTimeGreater;
        }
      }
      if (params.containsKey("serves") && params["serves"] != null) {
        if (params["serves"] >= 3) {
          servesQuery = RecipeQuery.servesGreater;
        } else {
          servesQuery = RecipeQuery.serves;
        }
      }
      if (params.containsKey("cuisines") &&
          params["cuisines"] != "" &&
          params["cuisines"] != null) {
        cuisinesQuery = RecipeQuery.cuisines;
      }

      querySnapshot = await recipesCollectionRef
          .queryBy(RecipeQuery.main, params)
          .queryBy(complexityQuery, params)
          .queryBy(servesQuery, params)
          .queryBy(cookTimeQuery, params)
          .queryBy(cuisinesQuery, params)
          .get();
    }

    var result = querySnapshot.docs.map((doc) async {
      String recipeId = doc.id;
      return RecipeModel.fromSnapshot(
        doc,
        ingredients: await getRecipeIngredients(recipeId),
        categories: await getRecipeCategories(recipeId),
        comments: await getRecipeComments(recipeId),
        steps: await getRecipeSteps(recipeId),
        tags: await getRecipeTags(recipeId),
      );
    }).toList();

    List<RecipeEntity> recipes = [];

    for (var element in result) {
      final recipe = await element;
      recipes.add(recipe);
    }
    return recipes;
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<List<RecipeEntity>> getRecipesFromFavorites() async {
    final uId = await getCurrentUId();
    final usersRecipesCollectionRef =
        firestore.collection("users").doc(uId).collection("favoriteRecipes");

    QuerySnapshot querySnapshot =
        await usersRecipesCollectionRef.orderBy("name").get();

    var result = querySnapshot.docs.map((doc) async {
      String recipeId = doc.id;
      return RecipeModel.fromSnapshot(
        doc,
        ingredients: await getRecipeIngredients(recipeId),
        categories: await getRecipeCategories(recipeId),
        comments: await getRecipeComments(recipeId),
        steps: await getRecipeSteps(recipeId),
        tags: await getRecipeTags(recipeId),
      );
    }).toList();

    List<RecipeEntity> recipes = [];

    for (var element in result) {
      final recipe = await element;
      recipes.add(recipe);
    }
    return recipes;
  }

  @override
  Future<List<ProductEntity>> getListOfUsersProducts() async {
    final uId = await getCurrentUId();
    final usersProductCollectionRef =
        firestore.collection("users").doc(uId).collection("products");

    QuerySnapshot querySnapshot =
        await usersProductCollectionRef.orderBy("name").get();

    return querySnapshot.docs
        .map((doc) => ProductModel.fromSnapshot(doc))
        .toList();
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> removeProductFromUserList(ProductEntity product) async {
    final uId = await getCurrentUId();
    final usersProductCollectionRef =
        firestore.collection("users").doc(uId).collection("products");

    await usersProductCollectionRef
        .doc(product.id)
        .get()
        .then((_product) async {
      if (_product.exists) {
        await usersProductCollectionRef.doc(product.id).delete();
      }
      return;
    });
  }

  @override
  Future<void> removeRecipeFromFavorites(RecipeEntity recipe) async {
    final uId = await getCurrentUId();
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
  Future<List<RecipeEntity>> searchRecipesByCategories(
      List<CategoryEntity> selectedCategories) async {
    final categoriesCollectionRef = firestore.collection("categories");
    final recipesCollectionRef = firestore.collection("recipes");

    QuerySnapshot querySnapshot = await recipesCollectionRef.get();

    var result = querySnapshot.docs.map((doc) async {
      String recipeId = doc.id;
      return RecipeModel.fromSnapshot(
        doc,
        ingredients: await getRecipeIngredients(recipeId),
        categories: await getRecipeCategories(recipeId),
        comments: await getRecipeComments(recipeId),
        steps: await getRecipeSteps(recipeId),
        tags: await getRecipeTags(recipeId),
      );
    }).toList();

    List<RecipeEntity> recipes = [];

    for (var element in result) {
      final recipe = await element;
      recipes.add(recipe);
    }
    return recipes;
  }

  @override
  Future<List<RecipeEntity>> searchRecipesByName(String name) async {
    const fieldName = "name";
    final productsCollectionRef = firestore
        .collection("recipes")
        .orderBy(fieldName)
        .where(fieldName, isGreaterThanOrEqualTo: name)
        .where(fieldName, isLessThan: '${name}z');

    QuerySnapshot querySnapshot = await productsCollectionRef.get();

    return querySnapshot.docs
        .map((doc) => RecipeModel.fromSnapshot(doc))
        .toList();
  }

  @override
  Future<List<RecipeEntity>> searchRecipesByProducts(
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
      .signInWithEmailAndPassword(email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => await auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      await auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  @override
  Future<void> updateProductFromUserList(ProductEntity product) async {
    final uId = await getCurrentUId();
    Map<String, dynamic> productMap = {};
    final usersProductsCollectionRef =
        firestore.collection("users").doc(uId).collection("products");

    productMap['unit'] = product.unit;

    await usersProductsCollectionRef.doc(product.id).update(productMap);
    return;
  }

  @override
  Future<List<ProductEntity>> searchProductsByName(String name) async {
    const fieldName = "name";
    final productsCollectionRef = firestore
        .collection("products")
        .orderBy(fieldName)
        .where(fieldName, isGreaterThanOrEqualTo: name)
        .where(fieldName, isLessThan: '${name}z');

    QuerySnapshot querySnapshot = await productsCollectionRef.get();

    return querySnapshot.docs
        .map((doc) => ProductModel.fromSnapshot(doc))
        .toList();
  }

  @override
  Future<void> resetPassword(UserEntity user) async {
    auth.sendPasswordResetEmail(email: user.email!);
    return;
  }

  @override
  Future<List<CuisineEntity>> getAllCuisines() async {
    final cuisinesCollectionRef = firestore.collection("cuisines");

    QuerySnapshot querySnapshot = await cuisinesCollectionRef.get();

    return querySnapshot.docs
        .map((doc) => CuisineModel.fromSnapshot(doc))
        .toList();
  }
}
