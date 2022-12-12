import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';

void snackBarError(
    {required BuildContext context, String? message, SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message ?? "Error",
        style: TextStyles.text16white,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
      action: action,
    ),
  );
}

void snackBarSuccess({required BuildContext context, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message ?? "Success",
        style: TextStyles.text16white,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
    ),
  );
}
