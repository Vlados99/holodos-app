import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/product/product_item.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';
import 'package:holodos/presentation/widgets/text_field.dart';

class ProductList extends StatefulWidget {
  final List<ProductEntity>? products;

  ProductList({super.key, this.products});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  TextEditingController _productUnitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final products = widget.products;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return separatedListView(products ?? state.products);
        }
        if (state is ProductFailure) {
          return ErrorPage();
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
          return GestureDetector(
            onTap: () => _dialogBuilder(
              context: context,
              product: products[index],
              index: index,
            ),
            child: ProductItem(name: products[index].name),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: products.length);
  }

  Future<void> _dialogBuilder(
      {required BuildContext context,
      required ProductEntity product,
      required int index}) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(product.name),
            content: inputRow(context, "Enter quantity"),
            actions: [
              GestureDetector(
                onTap: () {
                  submitAddProduct(product, index, context);
                },
                child: Text("Add"),
              ),
            ],
          );
        });
  }

  void submitAddProduct(
      ProductEntity product, int index, BuildContext context) {
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

  Widget inputRow(BuildContext context, String hintText) {
    return Container(
      child: SimpleTextField(
          context: context,
          controller: _productUnitController,
          labelText: hintText,
          formatters: [
            FilteringTextInputFormatter.digitsOnly,
          ]),
    );
  }
}
