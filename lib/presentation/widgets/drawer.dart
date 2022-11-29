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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return authState is Authenticated ? _drawer(true) : _drawer(false);
      },
    );
  }

  Widget _drawer(bool isSignIn) {
    return Drawer(
      backgroundColor: AppColors.mainBackground,
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          drawerHeader(text: "Holodos"),
          GestureDetector(
            onTap: () {
              if (widget.routeName != PageConst.recipesPage) {
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.recipesPage, (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
            child: drawerItem(
              icon: Icons.receipt_long_rounded,
              text: "Recipes",
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.routeName != PageConst.productsPage) {
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.productsPage, (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
            child: drawerItem(
              icon: Icons.list_alt_rounded,
              text: "Products",
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.routeName != PageConst.favoriteRecipesPage) {
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.favoriteRecipesPage, (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
            child: drawerItem(
              icon: Icons.star,
              text: "Favorite recipes",
            ),
          ),
          GestureDetector(
            onTap: () {
              if (widget.routeName != PageConst.availableProductsPage) {
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.availableProductsPage, (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
            child: drawerItem(
              icon: Icons.favorite_border,
              text: "My products",
            ),
          ),
          Container(
            child: isSignIn
                ? bottomDrawerItemSignOut(context)
                : bottomDrawerItemSignIn(context),
          ),
        ],
      ),
    );
  }

  Expanded bottomDrawerItemSignIn(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () => Navigator.pushNamedAndRemoveUntil(
          context, PageConst.signInPage, (route) => false),
      child: drawerItem(
        icon: Icons.logout,
        text: "Sign in",
        alignment: Alignment.bottomCenter,
      ),
    ));
  }

  Expanded bottomDrawerItemSignOut(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        BlocProvider.of<AuthCubit>(context).loggedOut();
        Navigator.pushNamedAndRemoveUntil(
            context, PageConst.signInPage, (route) => false);
      },
      child: drawerItem(
        icon: Icons.logout,
        text: "Sign out",
        alignment: Alignment.bottomCenter,
      ),
    ));
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

  Widget drawerItem({
    Color? backgroundColor,
    required IconData icon,
    required String text,
    Alignment? alignment,
  }) {
    return Align(
      alignment: alignment ?? Alignment.topLeft,
      child: Container(
        height: 60,
        color: backgroundColor ?? AppColors.mainBackground,
        child: Row(
          children: [
            CustomSizedBox().w15(),
            Icon(icon),
            CustomSizedBox().w15(),
            Text(
              text,
              style: TextStyles.text16black,
            ),
          ],
        ),
      ),
    );
  }
}
