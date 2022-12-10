import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';

import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/product/product_item.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';
import 'package:holodos/presentation/widgets/text_field.dart';

class ProductList extends StatefulWidget {
  final List<ProductEntity>? products;
  final bool? isFavorite;
  final bool? isAuth;

  const ProductList({
    Key? key,
    this.products,
    this.isAuth,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final TextEditingController _productUnitController = TextEditingController();

  bool isAuth = false;

  @override
  void initState() {
    isAuth = widget.isAuth ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.products;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return separatedListView(products ?? state.products);
        }
        if (state is ProductFailure) {
          return const ErrorPage();
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  ListView separatedListView(List<ProductEntity> products) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return productItem(products[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: products.length);
  }

  Widget productItem(ProductEntity product) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        GestureDetector(
          onTap: () {
            isAuth
                ? productDialog(product: product)
                : snackBarError(
                    context: context, message: "You are not logged in");
          },
          child: ProductItem(product: product),
        ),
        widget.isFavorite!
            ? Container(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () => removeProductDialog(product: product),
                  child: const Icon(
                    Icons.remove_circle_outline_rounded,
                    color: AppColors.black,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Future<void> removeProductDialog({required ProductEntity product}) {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Remove ${product.name}"),
            content: Text(
                "Do you really want to remove ${product.name} from your Holodos?"),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              GestureDetector(
                onTap: () => submitRemoveProduct(product),
                child: const Text("Remove"),
              ),
            ],
          );
        });
  }

  Future<void> productDialog({required ProductEntity product}) {
    _productUnitController.text = product.unit!;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(product.name),
            content: inputRow(),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              GestureDetector(
                onTap: () {
                  widget.isFavorite!
                      ? submitUpdateProduct(product)
                      : submitAddProduct(product);
                },
                child: Text(widget.isFavorite! ? "Update" : "Add"),
              ),
            ],
          );
        });
  }

  void submitUpdateProduct(ProductEntity product) {
    if (_productUnitController.text.isNotEmpty) {
      ProductEntity userProduct = ProductEntity(
          id: product.id,
          name: product.name,
          unit: _productUnitController.text);

      BlocProvider.of<ProductCubit>(context)
          .updateProductFromUserList(product: userProduct);
      Navigator.pop(context);
      snackBarSuccess(context: context, message: "Product is updated");
    } else {
      snackBarError(context: context, message: "Enter the value to text field");
    }

    _productUnitController.clear();
  }

  void submitAddProduct(ProductEntity product) {
    if (_productUnitController.text.isNotEmpty) {
      ProductEntity userProduct = ProductEntity(
          id: product.id,
          name: product.name,
          unit: _productUnitController.text);

      BlocProvider.of<ProductCubit>(context)
          .addProductToList(product: userProduct);
      Navigator.pop(context);
      snackBarSuccess(
          context: context, message: "Product has added to Holodos");
    } else {
      snackBarError(context: context, message: "Enter the value to text field");
    }

    _productUnitController.clear();
  }

  void submitRemoveProduct(ProductEntity product) {
    BlocProvider.of<ProductCubit>(context)
        .removeProductFromList(product: product);
    Navigator.pop(context);
    snackBarSuccess(context: context, message: "Product is removed");
  }

  Widget inputRow() {
    return SimpleTextField(
      controller: _productUnitController,
      labelText: "Enter quantity",
      formatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
    );
  }
}
