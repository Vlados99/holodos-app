import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_theme.dart';
import 'package:holodos/common/locator_service.dart' as di;
import 'package:holodos/common/on_generate_route.dart';
import 'package:holodos/presentation/bloc/search_product/search_product_bloc.dart';
import 'package:holodos/presentation/bloc/search_recipe/search_recipe_bloc.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/cuisine/cuisine_cubit.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/cubit/recipe_comments/recipe_comments_cubit.dart';
import 'package:holodos/presentation/cubit/user/user_cubit.dart';
import 'package:holodos/presentation/pages/recipes_page.dart';
import 'package:holodos/presentation/pages/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await di.init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..userIsSignIn()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<RecipeCubit>(create: (_) => di.sl<RecipeCubit>()),
        BlocProvider<ProductCubit>(create: (_) => di.sl<ProductCubit>()),
        BlocProvider<CuisineCubit>(create: (_) => di.sl<CuisineCubit>()),
        BlocProvider<CommentsCubit>(create: (_) => di.sl<CommentsCubit>()),
        BlocProvider<SearchRecipeBloc>(
            create: (_) => di.sl<SearchRecipeBloc>()),
        BlocProvider<SearchProductBloc>(
            create: (_) => di.sl<SearchProductBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme().lightTheme,
        darkTheme: AppTheme().darkTheme,
        title: "Holodos",
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return const RecipesPage();
              }
              if (authState is UnAuthenticated) {
                return const SignInPage();
              }
              return const CircularProgressIndicator();
            });
          }
        },
      ),
    );
  }
}
