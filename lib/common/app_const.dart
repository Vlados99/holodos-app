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
  static const String errorPage = "errorPage";
}

class AppColors {
  static const Color appBar = Colors.white;
  static const Color button = Color(0xFFF2822C);
  static const Color mainBackground = Colors.white;

  static const Color appBarTextColor = Colors.black;
  static const Color textColorBlack = Colors.black;
  static const Color textColorDirtyGreen = Color(0xFF267B6B);
  static const Color textColorGray = Color(0xFF858d9d);
  static const Color textColorWhite = Colors.white;

  static const Color orange = Color(0xFFF2822C);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color dirtyGreen = Color(0xFF267B6B);
}

class TextStyles {
  static const String poppins = "Poppins";
  static const String dancingScript = "DancingScript";

  static const TextStyle appBarTextStyle = TextStyle(
      color: AppColors.appBarTextColor,
      fontSize: 32,
      fontFamily: dancingScript);

  static const TextStyle header = TextStyle(
      fontSize: 42, color: AppColors.textColorBlack, fontFamily: dancingScript);

  static const TextStyle text32black = TextStyle(
      fontSize: 32, color: AppColors.textColorBlack, fontFamily: poppins);
  static const TextStyle text32White = TextStyle(
      fontSize: 32, color: AppColors.textColorWhite, fontFamily: poppins);
  static const TextStyle text16black = TextStyle(
      fontSize: 16, color: AppColors.textColorBlack, fontFamily: poppins);
  static const TextStyle text16green = TextStyle(
      fontSize: 16, color: AppColors.textColorDirtyGreen, fontFamily: poppins);
  static const TextStyle text16blackBold = TextStyle(
      fontSize: 16,
      color: AppColors.textColorBlack,
      fontFamily: poppins,
      fontWeight: FontWeight.bold);
  static const TextStyle text16gray = TextStyle(
      fontSize: 16, color: AppColors.textColorGray, fontFamily: poppins);
  static const TextStyle text16white = TextStyle(
      fontSize: 16, color: AppColors.textColorWhite, fontFamily: poppins);
  static const TextStyle text12white = TextStyle(
      fontSize: 12, color: AppColors.textColorWhite, fontFamily: poppins);
  static const TextStyle text12black = TextStyle(
      fontSize: 12, color: AppColors.textColorBlack, fontFamily: poppins);
  static const TextStyle text24white = TextStyle(
      fontSize: 24, color: AppColors.textColorWhite, fontFamily: poppins);
  static const TextStyle text24black = TextStyle(
      fontSize: 24, color: AppColors.textColorBlack, fontFamily: poppins);
  static const TextStyle text24blackBold = TextStyle(
      fontSize: 24,
      color: AppColors.textColorBlack,
      fontFamily: poppins,
      fontWeight: FontWeight.bold);

  static TextStyle productTextStyle = TextStyle(
    fontSize: 32,
    fontFamily: poppins,
    color: AppColors.textColorBlack,
    shadows: [
      Shadow(
        color: AppColors.dirtyGreen.withOpacity(0.3),
        offset: const Offset(0, 1),
      ),
    ],
  );
}
