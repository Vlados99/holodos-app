import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/product_item.dart';

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
    return Column(
      children: [
        search(),
        productsListView(productLoadedState),
      ],
    );
  }

  ListView productsListView(ProductLoaded productLoadedState) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: productLoadedState.products.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () => _dialogBuilder(
            context: context,
            productLoadedState: productLoadedState,
            index: index,
          ),
          child: ProductItem(state: productLoadedState, index: index),
        );
      },
    );
  }

  Future<void> _dialogBuilder(
      {required BuildContext context,
      required ProductLoaded productLoadedState,
      required int index}) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("${productLoadedState.products[index].name}"),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text("Add"),
              ),
            ],
          );
        });
  }

  Widget search() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: AppColors.black,
            width: 1,
          )),
      height: 50,
      child: Container(
        alignment: FractionalOffset.center,
        padding: EdgeInsets.only(left: 10),
        child: Text(
          "Search",
          style: TextStyles.text16black,
        ),
      ),
    );
  }
}
