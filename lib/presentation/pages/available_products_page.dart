import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/cubit/user_product/user_product_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/appbar/app_bar.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/product/product_list.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';

class AvailableProductsPage extends StatefulWidget {
  const AvailableProductsPage({Key? key}) : super(key: key);

  @override
  State<AvailableProductsPage> createState() => _AvailableProductsPageState();
}

class _AvailableProductsPageState extends State<AvailableProductsPage> {
  final GlobalKey<ScaffoldState> _scaffolGlobalKey = GlobalKey<ScaffoldState>();

  bool isAuth = false;

  final TextEditingController _productSearchController =
      TextEditingController();

  @override
  void initState() {
    BlocProvider.of<UserProductCubit>(context).getProductsFromList();

    super.initState();
  }

  @override
  void dispose() {
    _productSearchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        isAuth = authState is Authenticated ? true : false;
        return isAuth ? _bodyWidget() : notLoggedIn();
      },
    );
  }

  Widget notLoggedIn() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SafeArea(
          child: AppDrawer(
        routeName: PageConst.availableProductsPage,
        width: MediaQuery.of(context).size.width - 80,
      )),
      key: _scaffolGlobalKey,
      appBar: const MainAppBar(
        title: "Holodos",
      ),
      body: centerWidget(
        icon: const Icon(Icons.no_accounts),
        mainText: "Unfortunately, you are not logged in. ",
        buttonText: "Sign in",
        page: PageConst.signInPage,
      ),
    );
  }

  Widget centerWidget({
    required Icon icon,
    required String mainText,
    required String buttonText,
    required String page,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mainText,
              style: TextStyles.text16black,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, page, (route) => false);
              },
              child: Button(
                text: buttonText,
                fontColor: AppColors.textColorDirtyGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _noProductsWidget() {
    return centerWidget(
        icon: const Icon(Icons.no_food),
        mainText: "You don't have food in Holodos? ",
        buttonText: "Add them!",
        page: PageConst.productsPage);
  }

  Widget _bodyWidget() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SafeArea(
          child: AppDrawer(
        routeName: PageConst.availableProductsPage,
        width: MediaQuery.of(context).size.width - 80,
      )),
      key: _scaffolGlobalKey,
      appBar: const MainAppBar(
        title: "Holodos",
      ),
      body: BlocBuilder<UserProductCubit, UserProductState>(
        builder: (context, userProductState) {
          if (userProductState is UserProductLoaded) {
            List<ProductEntity> products = userProductState.products;
            return Container(
              alignment: Alignment.topCenter,
              child:
                  products.isEmpty ? _noProductsWidget() : _products(products),
            );
          }
          if (userProductState is UserProductFailure) {
            return const ErrorPage();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.recipesPage, (route) => false);
                BlocProvider.of<RecipesCubit>(context).searchRecipesByProducts(
                    products: products.map((e) => e.name).toList());
              },
              child: Button(
                text: "Search by my products",
                backgroundColor: products.isEmpty
                    ? AppColors.dirtyGreen.withOpacity(0.4)
                    : AppColors.dirtyGreen,
                fontColor: AppColors.textColorWhite,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
          ),
        ),
        ProductList(
          products: products,
          isFavorite: true,
          isAuth: isAuth,
        ),
      ],
    );
  }
}
