import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/widgets/sized_box.dart';

class AppDrawer extends StatelessWidget {
  String routeName;
  double width;
  BuildContext context;

  AppDrawer({
    Key? key,
    required this.routeName,
    required this.width,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.mainBackground,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          drawerHeader(text: "Holodos"),
          GestureDetector(
            onTap: () {
              if (routeName != PageConst.recipesPage) {
                BlocProvider.of<RecipeCubit>(context).getRecipes();
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.recipesPage, (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
            child: drawerListElement(
              icon: Icons.receipt_long_rounded,
              text: "Recipes",
            ),
          ),
          GestureDetector(
            onTap: () {
              if (routeName != PageConst.productsPage) {
                BlocProvider.of<ProductCubit>(context).getProducts();
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.productsPage, (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
            child: drawerListElement(
              icon: Icons.list_alt_rounded,
              text: "Products",
            ),
          ),
          GestureDetector(
            onTap: () {
              if (routeName != PageConst.favoriteRecipesPage) {
                BlocProvider.of<RecipeCubit>(context)
                    .getRecipesFromFavoritesUseCase();
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.favoriteRecipesPage, (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
            child: drawerListElement(
              icon: Icons.star,
              text: "Favorite recipes",
            ),
          ),
          GestureDetector(
            onTap: () {
              if (routeName != PageConst.availableProductsPage) {
                BlocProvider.of<ProductCubit>(context).getProductsFromList();
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.availableProductsPage, (route) => false);
              } else {
                Navigator.pop(context);
              }
            },
            child: drawerListElement(
              icon: Icons.favorite_border,
              text: "My products",
            ),
          ),
          Expanded(
              child: GestureDetector(
            onTap: () => BlocProvider.of<AuthCubit>(context).loggedOut(),
            child: drawerListElement(
              icon: Icons.logout,
              text: "Sign out",
              alignment: Alignment.bottomCenter,
            ),
          )),
        ],
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

  Widget drawerListElement({
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
            sb_w15(),
            Icon(icon),
            sb_w15(),
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
