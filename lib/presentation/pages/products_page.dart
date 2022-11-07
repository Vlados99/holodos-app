import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/drawer.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  GlobalKey<ScaffoldState> _scaffolGlobalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() {
    return Scaffold(
      drawer: SafeArea(
          child: drawer(PageConst.productsPage,
              MediaQuery.of(context).size.width - 80, context)),
      key: _scaffolGlobalKey,
      appBar: mainAppBar(title: "Products"),
      body: BlocBuilder<ProductCubit, ProductState>(
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
      ),
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
    return Container(
      alignment: Alignment.topCenter,
      child: productLoadedState.products.isEmpty
          ? _noProductsWidget()
          : _productsList(productLoadedState),
    );
  }

  Widget _productsList(ProductLoaded productLoadedState) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemCount: productLoadedState.products.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            child: Text("${productLoadedState.products[index].name}"),
          ),
        );
      },
    );
  }
}
