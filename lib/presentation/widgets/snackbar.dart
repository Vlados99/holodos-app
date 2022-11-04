import 'package:flutter/material.dart';

void snackBarError({required BuildContext context, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Text(message ?? "error"),
        ],
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.deepOrange,
    ),
  );
}
