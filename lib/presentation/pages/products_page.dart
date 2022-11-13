import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/product/product_search_delegate.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/product/product_list.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  GlobalKey<ScaffoldState> _scaffolGlobalKey = GlobalKey<ScaffoldState>();

  TextEditingController _productSearchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).getProducts();

    super.initState();
  }

  @override
  void dispose() {
    _productSearchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() {
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
        Text("Products are not found!"),
      ],
    );
  }

  Widget _bodyWidget(ProductLoaded productLoadedState) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SafeArea(
          child: AppDrawer(
              routeName: PageConst.productsPage,
              width: MediaQuery.of(context).size.width - 80,
              context: context)),
      key: _scaffolGlobalKey,
      appBar: MainAppBar(
        title: "Products",
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
        // search(),
        ProductList(),
      ],
    );
  }
/*
  Widget search() {
    return GestureDetector(
      onTap: () {
        showSearch(context: context, delegate: CustomSearchDelegate());
        snackBarSuccess(context: context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: SearchTextField(
          width: MediaQuery.of(context).size.width - 80,
          context: context,
          controller: _productSearchController,
          labelText: "Enter product name",
        ),
      ),
    );
  }*/
}
