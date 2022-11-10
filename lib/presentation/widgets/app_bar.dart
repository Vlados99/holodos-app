import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';

AppBar simpleAppBar({String? title}) {
  return AppBar(
    title: Text(
      title ?? '',
      style: TextStyles.appBarTextStyle,
    ),
  );
}

AppBar mainAppBarWithoutLogIn({required String title}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyles.appBarTextStyle,
    ),
  );
}

AppBar mainAppBar({required String title}) {
  const bool value = false;
  return AppBar(
    title: Text(
      title,
      style: TextStyles.appBarTextStyle,
    ),
    actions: [
      Switch(value: value, onChanged: (value) => !value),
    ],
  );
}
