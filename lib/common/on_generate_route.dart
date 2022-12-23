import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/pages/available_products_page.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/pages/favorite_recipes_page.dart';
import 'package:holodos/presentation/pages/products_page.dart';
import 'package:holodos/presentation/pages/recipe_detail_page.dart';
import 'package:holodos/presentation/pages/recipes_page.dart';
import 'package:holodos/presentation/pages/reset_password_page.dart';
import 'package:holodos/presentation/pages/sign_in_page.dart';
import 'package:holodos/presentation/pages/sign_up_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.recipePage:
        {
          return args is Map
              ? materialBuilder(
                  widget: RecipePage(
                  recipe: args["recipe"],
                  fromPageName: args["pageName"],
                ))
              : materialBuilder(widget: const ErrorPage());
        }

      case PageConst.signUpPage:
        return materialBuilder(widget: const SignUpPage());

      case PageConst.signInPage:
        return materialBuilder(widget: const SignInPage());

      case PageConst.resetPasswordPage:
        return materialBuilder(widget: const ResetPasswordPage());

      case PageConst.productsPage:
        return materialBuilder(widget: const ProductsPage());

      case PageConst.recipesPage:
        return args is Map
            ? materialBuilder(
                widget: RecipesPage(
                fromFavoritePage: args["fromFavoritePage"],
                products: args["products"],
              ))
            : materialBuilder(widget: const RecipesPage());

      case PageConst.favoriteRecipesPage:
        return materialBuilder(widget: const FavoriteRecipesPage());

      case PageConst.availableProductsPage:
        return materialBuilder(widget: const AvailableProductsPage());

      default:
        {
          return args is Map
              ? materialBuilder(
                  widget: ErrorPage(
                  title: args["title"],
                  message: args["message"],
                ))
              : materialBuilder(widget: const ErrorPage());
        }
    }
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
