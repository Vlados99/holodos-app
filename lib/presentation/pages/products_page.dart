import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/product/product_search_delegate.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/product/product_list.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key? key}) : super(key: key);

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
    return _builder();
  }

  Widget _builder() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        if (productState is ProductLoaded) {
          return _bodyWidget(productState.products);
        }
        if (productState is ProductFailure) {
          return ErrorPage();
        }

        return const Center(
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

  Widget _bodyWidget(List<ProductEntity> products) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SafeArea(
          child: AppDrawer(
        routeName: PageConst.productsPage,
        width: MediaQuery.of(context).size.width - 80,
      )),
      key: _scaffolGlobalKey,
      appBar: MainAppBar(
        title: "Products",
        search: true,
        searchDelegate: ProductSearchDelegate(),
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
        ProductList(),
      ],
    );
  }
}
