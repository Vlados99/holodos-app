import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/widgets/appbar/filter/filter.dart';

double _appbarHeight = 56;

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool? search;
  final SearchDelegate? searchDelegate;

  final bool? filter;

  const MainAppBar({
    Key? key,
    this.title,
    this.search = false,
    this.searchDelegate,
    this.filter = false,
  }) : super(key: key);

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_appbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        widget.title ?? '',
        style: TextStyles.appBarTextStyle,
      ),
      actions: [
        widget.filter! ? const FilterAppBarItem() : Container(),
        widget.search!
            ? GestureDetector(
                onTap: () {
                  showSearch(
                      context: context, delegate: widget.searchDelegate!);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.search,
                    color: AppColors.dirtyGreen,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
