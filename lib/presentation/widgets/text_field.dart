import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';

Widget textField(
    {required BuildContext context,
    required TextEditingController controller,
    String? hintText}) {
  controller.clear();
  return Container(
    width: MediaQuery.of(context).size.width - 30,
    child: TextField(
      cursorColor: AppColors.appBar,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.appBar))),
    ),
  );
}
