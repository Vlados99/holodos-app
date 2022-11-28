import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';

class AppTheme {
  get lightTheme => ThemeData(
        primaryColor: AppColors.appBar,
        appBarTheme: const AppBarTheme(
            color: AppColors.appBar, foregroundColor: AppColors.orange),
        backgroundColor: AppColors.mainBackground,
        scaffoldBackgroundColor: AppColors.mainBackground,
      );

  get darkTheme => ThemeData();
}
