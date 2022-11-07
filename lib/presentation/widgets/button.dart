import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';

Widget button({
  double? width,
  required BuildContext context,
  Color? backgroundColor,
  required String text,
  Color? fontColor,
}) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    height: 40,
    width: width ?? MediaQuery.of(context).size.width / 2,
    child: Text(
      "${text}",
      style: TextStyle(
        color: fontColor ?? AppColors.textColorBlack,
        fontSize: 18,
      ),
    ),
  );
}
