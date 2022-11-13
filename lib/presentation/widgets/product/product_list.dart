import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/widgets/product/product_search_result.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';
import 'package:holodos/presentation/widgets/text_field.dart';

class ProductList extends StatelessWidget {
  TextEditingController _productUnitController = TextEditingController();
  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        List<ProductEntity> products = [];
        if (state is ProductLoaded) {
          products = state.products;

          return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _dialogBuilder(
                    context: context,
                    productLoadedState: state,
                    index: index,
                  ),
                  child: ProductItem(name: state.products[index].name),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: products.length);
        }

        return const Center(child: CircularProgressIndicator());
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
            content: inputRow(context, "Enter quantity"),
            actions: [
              GestureDetector(
                onTap: () {
                  submitAddProduct(productLoadedState, index, context);
                },
                child: Text("Add"),
              ),
            ],
          );
        });
  }

  void submitAddProduct(
      ProductLoaded productLoadedState, int index, BuildContext context) {
    if (_productUnitController.text.isNotEmpty) {
      ProductEntity product = ProductEntity(
          id: productLoadedState.products[index].id,
          name: productLoadedState.products[index].name,
          unit: _productUnitController.text);

      BlocProvider.of<ProductCubit>(context).addProductToList(product: product);
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
