import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/widgets/sized_box.dart';

Drawer drawer(String routeName, double width, BuildContext context) => Drawer(
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
          Expanded(
              child: GestureDetector(
            onTap: () => BlocProvider.of<AuthCubit>(context).loggedOut(),
            child: drawerListElement(
              icon: Icons.logout,
              text: "Sign out",
              alignment: Alignment.bottomCenter,
            ),
          )),
          /*
          Expanded(
            child: BlocProvider.of<AuthCubit>(context).isSignedIn
                ? GestureDetector(
                    onTap: () =>
                        BlocProvider.of<AuthCubit>(context).loggedOut(),
                    child: drawerListElement(
                      icon: Icons.logout,
                      text: "Sign out",
                      alignment: Alignment.bottomCenter,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageConst.signInPage);
                    },
                    child: drawerListElement(
                      icon: Icons.login,
                      text: "Sign in",
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
          ),*/
        ],
      ),
    );

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
