import 'package:flutter/material.dart';

void snackBarError({required BuildContext context, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message ?? "Error",
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    ),
  );
}

void snackBarSuccess({required BuildContext context, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message ?? "Success",
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
    ),
  );
}
