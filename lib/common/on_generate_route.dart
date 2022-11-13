import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/pages/error_page.dart';
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
          return args is RecipeEntity
              ? materialBuilder(widget: RecipePage(recipe: args))
              : materialBuilder(widget: ErrorPage());
        }

      case PageConst.signUpPage:
        return materialBuilder(widget: SignUpPage());

      case PageConst.signInPage:
        return materialBuilder(widget: SignInPage());

      case PageConst.resetPasswordPage:
        return materialBuilder(widget: ResetPasswordPage());

      case PageConst.productsPage:
        return materialBuilder(widget: ProductsPage());

      case PageConst.recipesPage:
        return materialBuilder(widget: RecipesPage());

      default:
        return materialBuilder(widget: ErrorPage());
    }
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
