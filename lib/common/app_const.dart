import 'package:flutter/material.dart';

class PageConst {
  static const String signUpPage = "signUpPage";
  static const String signInPage = "signInPage";
  static const String recipePage = "recipePage";
  static const String recipesPage = "recipesPage";
  static const String availableProductsPage = "availableProductsPage";
  static const String favoriteRecipesPage = "favoriteRecipesPage";
  static const String productsPage = "productsPage";
  static const String resetPasswordPage = "resetPasswordPage";
}

class AppColors {
  static const Color appBar = Color(0xFFF2822C);
  static const Color button = Color(0xFFF2822C);
  static const Color mainBackground = Colors.white;

  static const Color appBarTextColor = Colors.white;
  static const Color textColorBlack = Colors.black;
  static const Color textColorDirtyGreen = Color(0xFF267B6B);
  static const Color textColorGray = Color(0xFF858d9d);
  static const Color textColorWhite = Colors.white;

  static const Color orange = Color(0xFFF2822C);
  static const Color black = Colors.black;
}

class TextStyles {
  static const TextStyle appBarTextStyle =
      TextStyle(color: AppColors.appBarTextColor);

  static const TextStyle header = TextStyle(
      fontSize: 42,
      color: AppColors.textColorBlack,
      fontFamily: "DancingScript");

  static const TextStyle text32black =
      TextStyle(fontSize: 32, color: AppColors.textColorBlack);
  static const TextStyle text32White =
      TextStyle(fontSize: 32, color: AppColors.textColorWhite);
  static const TextStyle text16black =
      TextStyle(fontSize: 16, color: AppColors.textColorBlack);
  static const TextStyle text16gray =
      TextStyle(fontSize: 16, color: AppColors.textColorGray);
}
