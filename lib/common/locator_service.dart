import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:holodos/data/datasources/user_remote_data_source.dart';
import 'package:holodos/data/datasources/user_remote_data_source_impl.dart';
import 'package:holodos/data/repositories/user_repository_impl.dart';
import 'package:holodos/domain/repositories/user_repository.dart';
import 'package:holodos/domain/usecases/add_product_to_user_list.dart';
import 'package:holodos/domain/usecases/add_recipe_to_favorites.dart';
import 'package:holodos/domain/usecases/commentOnRecipe.dart';
import 'package:holodos/domain/usecases/create_current_user.dart';
import 'package:holodos/domain/usecases/get_all_products.dart';
import 'package:holodos/domain/usecases/get_all_recipes.dart';
import 'package:holodos/domain/usecases/get_current_user_id.dart';
import 'package:holodos/domain/usecases/get_list_of_users_products.dart';
import 'package:holodos/domain/usecases/get_recipes_from_favorites.dart';
import 'package:holodos/domain/usecases/is_sign_in.dart';
import 'package:holodos/domain/usecases/remove_product_from_user_list.dart';
import 'package:holodos/domain/usecases/remove_recipe_from_favorites.dart';
import 'package:holodos/domain/usecases/search_recipes_by_categories.dart';
import 'package:holodos/domain/usecases/search_recipes_by_name.dart';
import 'package:holodos/domain/usecases/search_recipes_by_products.dart';
import 'package:holodos/domain/usecases/share_recipe.dart';
import 'package:holodos/domain/usecases/sign_in.dart';
import 'package:holodos/domain/usecases/sign_out.dart';
import 'package:holodos/domain/usecases/sign_up.dart';
import 'package:holodos/domain/usecases/update_product_from_user_list.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/cubit/user/user_cubit.dart';

final sl = GetIt.instance;

init() {
  // Bloc / Cubit
  /*
  sl.registerFactory(() => RecipeListCubit(getAllRecipes: sl()));
  sl.registerFactory(() => RecipeSearchBloc(
      searchRecipesByCategories: sl(),
      searchRecipesByProducts: sl(),
      searchRecipesByName: sl()));*/
  sl.registerFactory(() => AuthCubit(
        isSignIn: sl(),
        signOut: sl(),
        getCurrentUserId: sl(),
      ));
  sl.registerFactory(() => UserCubit(
        signIn: sl(),
        signUp: sl(),
        createCurrentUser: sl(),
      ));
  sl.registerFactory(() => RecipeCubit(
        removeRecipeFromFavoritesUseCase: sl(),
        getRecipesFromFavoritesUseCase: sl(),
        addRecipeToFavoritesUseCase: sl(),
        getAllRecipesUseCase: sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => AddProductToUserList(repository: sl()));
  sl.registerLazySingleton(() => AddRecipeToFavorites(repository: sl()));
  sl.registerLazySingleton(() => CommentOnRecipe(repository: sl()));
  sl.registerLazySingleton(() => CreateCurrentUser(repository: sl()));
  sl.registerLazySingleton(() => GetAllProducts(repository: sl()));
  sl.registerLazySingleton(() => GetAllRecipes(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserId(repository: sl()));
  sl.registerLazySingleton(() => GetListOfUsersProducts(repository: sl()));
  sl.registerLazySingleton(() => GetRecipesFromFavorites(repository: sl()));
  sl.registerLazySingleton(() => IsSignIn(repository: sl()));
  sl.registerLazySingleton(() => RemoveProductFromUserList(repository: sl()));
  sl.registerLazySingleton(() => RemoveRecipeFromFavorites(repository: sl()));
  sl.registerLazySingleton(() => SearchRecipesByCategories(repository: sl()));
  sl.registerLazySingleton(() => SearchRecipesByName(repository: sl()));
  sl.registerLazySingleton(() => SearchRecipesByProducts(repository: sl()));
  sl.registerLazySingleton(() => ShareRecipe(repository: sl()));
  sl.registerLazySingleton(() => SignIn(repository: sl()));
  sl.registerLazySingleton(() => SignOut(repository: sl()));
  sl.registerLazySingleton(() => SignUp(repository: sl()));
  sl.registerLazySingleton(() => UpdateProductFromUserList(repository: sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(auth: sl(), firestore: sl()));

  // Core

  // External
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}
