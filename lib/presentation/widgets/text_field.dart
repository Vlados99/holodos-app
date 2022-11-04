import 'package:flutter/material.dart';

class CustomTextField {
  Widget textField(
      {required TextEditingController controller, String? hingText}) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hingText),
      ),
    );
  }
}
