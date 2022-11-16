import 'package:flutter/material.dart';

import 'package:holodos/common/app_const.dart';

class Button extends StatelessWidget {
  double? width;
  Color? backgroundColor;
  String text;
  Color? fontColor;

  Button({
    Key? key,
    this.width,
    this.backgroundColor,
    required this.text,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: 40,
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
