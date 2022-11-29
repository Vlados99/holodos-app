import 'package:flutter/material.dart';

import 'package:holodos/common/app_const.dart';

class Button extends StatelessWidget {
  final double? width;
  final Color? backgroundColor;
  final String text;
  final Color? fontColor;
  final Alignment? alignment;

  const Button({
    Key? key,
    this.width,
    this.backgroundColor,
    required this.text,
    this.fontColor,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      height: 35,
      width: width,
      child: Text(
        text,
        style: TextStyle(
          color: fontColor ?? AppColors.textColorBlack,
          fontSize: 16,
        ),
      ),
    );
  }
}
