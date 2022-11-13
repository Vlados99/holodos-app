import 'package:flutter/material.dart';

import 'package:holodos/common/app_const.dart';

double _appbarHeight = 56;

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  bool? search;
  SearchDelegate? delegate;

  MainAppBar({
    Key? key,
    this.title,
    this.search = false,
    this.delegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bool value = false;
    return AppBar(
      title: Text(
        title ?? '',
        style: TextStyles.appBarTextStyle,
      ),
      actions: [
        search!
            ? GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: delegate!);
                },
                child: Container(
                  child: Icon(Icons.search),
                  padding: EdgeInsets.only(right: 16),
                ),
              )
            : Container(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appbarHeight);
}
