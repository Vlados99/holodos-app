import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
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
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        if (productState is ProductLoaded) {
          return _bodyWidget(productState);
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

  Widget _noProductsWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.no_food),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "You don't have food in Holodos? ",
              style: TextStyles.text16black,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.productsPage, (route) => false);
              },
              child: Button(
                width: 90,
                context: context,
                text: "Add them!",
                fontColor: AppColors.textColorDirtyGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bodyWidget(ProductLoaded productLoadedState) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SafeArea(
          child: AppDrawer(
              routeName: PageConst.availableProductsPage,
              width: MediaQuery.of(context).size.width - 80,
              context: context)),
      key: _scaffolGlobalKey,
      appBar: MainAppBar(
        title: "Holodos",
        search: true,
        delegate: ProductSearchDelegate(),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: productLoadedState.products.isEmpty
            ? _noProductsWidget()
            : _products(productLoadedState),
      ),
    );
  }

  Widget _products(ProductLoaded productLoadedState) {
    return Column(
      children: [
        ProductList(
          isFavorite: true,
        ),
      ],
    );
  }
}
