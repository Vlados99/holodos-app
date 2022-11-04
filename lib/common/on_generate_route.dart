import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/pages/recipe_page.dart';
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

      default:
        return materialBuilder(widget: ErrorPage());
    }
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
