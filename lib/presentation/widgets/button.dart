import 'package:flutter/material.dart';

import 'package:holodos/common/app_const.dart';

class Button extends StatelessWidget {
  double? width;
  BuildContext context;
  Color? backgroundColor;
  String text;
  Color? fontColor;

  Button({
    Key? key,
    this.width,
    required this.context,
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
      width: width ?? MediaQuery.of(context).size.width / 1.5,
      child: Text(
        "${text}",
        style: TextStyle(
          color: fontColor ?? AppColors.textColorBlack,
          fontSize: 18,
        ),
      ),
    );
  }
}
