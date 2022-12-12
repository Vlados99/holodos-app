import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/widgets/sized_box.dart';

class AppDrawer extends StatefulWidget {
  final String routeName;
  final double width;

  const AppDrawer({
    Key? key,
    required this.routeName,
    required this.width,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String routeName = "";

  @override
  void initState() {
    routeName = widget.routeName;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return authState is Authenticated ? _drawer(true) : _drawer(false);
      },
    );
  }

  List<Map<String, dynamic>> listDrawerItem = [
    {
      "icon": Icons.receipt_long_rounded,
      "text": "Recipes",
      "pageName": PageConst.recipesPage
    },
    {
      "icon": Icons.list_alt_rounded,
      "text": "Products",
      "pageName": PageConst.productsPage
    },
    {
      "icon": Icons.star,
      "text": "Favorite recipes",
      "pageName": PageConst.favoriteRecipesPage
    },
    {
      "icon": Icons.favorite_border,
      "text": "My products",
      "pageName": PageConst.availableProductsPage
    },
  ];

  Widget _drawer(bool isSignIn) {
    var list = listDrawerItem.map((e) {
      return DrawerItem(
        icon: e["icon"],
        text: e["text"],
        selectedMenuItem: routeName,
        currentPageName: e["pageName"],
        isSelected: routeName == e["pageName"],
      );
    }).toList();

    return Drawer(
      backgroundColor: AppColors.mainBackground,
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          drawerHeader(text: "Holodos"),
          for (var el in list) el,
          Container(
            child: bottomDrawerItemSignIn(context, isSignIn),
          ),
        ],
      ),
    );
  }

  Widget bottomDrawerItemSignIn(BuildContext context, bool isSignIn) {
    return Expanded(
      child: DrawerItem(
        onTap: () {
          if (isSignIn) {
            BlocProvider.of<AuthCubit>(context).loggedOut();
            Navigator.pushNamedAndRemoveUntil(
                context, PageConst.signInPage, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, PageConst.signInPage, (route) => false);
          }
        },
        icon: Icons.logout,
        text: isSignIn ? "Sign out" : "Sign in",
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  Widget drawerHeader({
    required String text,
    Color? backgroundColor,
  }) {
    return Container(
      alignment: Alignment.topCenter,
      color: backgroundColor ?? AppColors.appBar,
      child: DrawerHeader(
        child: Text(
          text,
          style: TextStyles.header,
        ),
      ),
    );
  }
}

class DrawerItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final Alignment? alignment;
  final bool? isSelected;
  final String? selectedMenuItem;
  final String? currentPageName;
  final Function()? onTap;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.text,
    this.alignment,
    this.isSelected,
    this.selectedMenuItem,
    this.currentPageName,
    this.onTap,
  }) : super(key: key);

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool isSelected = false;
  String currentPageName = "";

  @override
  void initState() {
    isSelected = widget.isSelected ?? false;
    currentPageName = widget.currentPageName ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ??
          () {
            if (widget.selectedMenuItem != currentPageName) {
              Navigator.pushNamedAndRemoveUntil(
                  context, currentPageName, (route) => false);
            } else {
              Navigator.pop(context);
            }
          },
      child: Align(
        alignment: widget.alignment ?? Alignment.topLeft,
        child: Container(
          height: 60,
          color: isSelected ? AppColors.orange : AppColors.mainBackground,
          child: Row(
            children: [
              CustomSizedBox().w15(),
              Icon(
                widget.icon,
                color: isSelected ? AppColors.white : AppColors.black,
              ),
              CustomSizedBox().w15(),
              Text(
                widget.text,
                style: isSelected
                    ? TextStyles.text16white
                    : TextStyles.text16black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
