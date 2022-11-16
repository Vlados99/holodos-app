import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/product/product_list.dart';
import 'package:holodos/presentation/widgets/product/product_search_delegate.dart';

class AvailableProductsPage extends StatefulWidget {
  @override
  State<AvailableProductsPage> createState() => _AvailableProductsPageState();
}

class _AvailableProductsPageState extends State<AvailableProductsPage> {
  GlobalKey<ScaffoldState> _scaffolGlobalKey = GlobalKey<ScaffoldState>();

  TextEditingController _productSearchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).getProductsFromList();

    super.initState();
  }

  @override
  void dispose() {
    _productSearchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _builder();
  }

  Widget _builder() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return authState is Authenticated ? productBuilder() : notLoggedIn();
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
      appBar: MainAppBar(
        title: "Holodos",
      ),
      body: centerWidget(
        icon: Icon(Icons.no_accounts),
        mainText: "Unfortunately, you are not logged in. ",
        buttonText: "Sign in",
        page: PageConst.signInPage,
      ),
    );
  }

  BlocBuilder<ProductCubit, ProductState> productBuilder() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        if (productState is ProductLoaded) {
          return _bodyWidget(productState.products);
        }
        if (productState is ProductFailure) {
          return ErrorPage();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
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
        icon: Icon(Icons.no_food),
        mainText: "You don't have food in Holodos? ",
        buttonText: "Add them!",
        page: PageConst.productsPage);
  }

  Widget _bodyWidget(List<ProductEntity> products) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SafeArea(
          child: AppDrawer(
        routeName: PageConst.availableProductsPage,
        width: MediaQuery.of(context).size.width - 80,
      )),
      key: _scaffolGlobalKey,
      appBar: MainAppBar(
        title: "Holodos",
        search: true,
        delegate: ProductSearchDelegate(),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: products.isEmpty ? _noProductsWidget() : _products(),
      ),
    );
  }

  Widget _products() {
    return Column(
      children: [
        ProductList(
          isFavorite: true,
        ),
      ],
    );
  }
}
