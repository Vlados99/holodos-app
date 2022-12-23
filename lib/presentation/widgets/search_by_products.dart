import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/cubit/user_product/user_product_cubit.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';

class SearchByProducts extends StatefulWidget {
  const SearchByProducts({Key? key}) : super(key: key);

  @override
  State<SearchByProducts> createState() => _SearchByProductsState();
}

class _SearchByProductsState extends State<SearchByProducts> {
  List<String> selectedProductsList = [];
  bool isListNotEmpty = false;

  @override
  void initState() {
    BlocProvider.of<UserProductCubit>(context).getProductsFromList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        products(),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: selectedProducts(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              searchByUserProductsButton(),
              searchButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget searchByUserProductsButton() {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState) {
      return authState is Authenticated ? buttonBuilder() : Container();
    });
  }

  BlocBuilder<UserProductCubit, UserProductState> buttonBuilder() {
    return BlocBuilder<UserProductCubit, UserProductState>(
      builder: (context, productState) {
        if (productState is UserProductLoaded) {
          List<ProductEntity> products = productState.products;
          return Container(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                if (products.isEmpty) {
                  snackBarError(
                    context: context,
                    message: "Your product list is empty",
                    action: SnackBarAction(
                        label: 'Add them',
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              PageConst.productsPage, (route) => false);
                        }),
                  );

                  return;
                }

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
          );
        }
        if (productState is UserProductFailure) {
          return Container();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget searchButton() {
    return GestureDetector(
      onTap: () {
        // if (!isListNotEmpty) {
        //   return;
        // }
        if (selectedProductsList.isEmpty) {
          snackBarError(
              context: context,
              message: "The list of selected products is empty");
          return;
        }

        BlocProvider.of<RecipesCubit>(context)
            .searchRecipesByProducts(products: selectedProductsList);
      },
      child: Button(
        text: "Search",
        backgroundColor: isListNotEmpty
            ? AppColors.dirtyGreen
            : AppColors.dirtyGreen.withOpacity(0.4),
        fontColor: AppColors.textColorWhite,
        width: MediaQuery.of(context).size.width / 3,
      ),
    );
  }

  Widget selectedProducts() {
    return selectedProductsList.isEmpty
        ? Container()
        : Wrap(
            children: selectedProductsList.map((e) => productItem(e)).toList());
  }

  Widget productItem(String name) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      decoration: const BoxDecoration(color: AppColors.mainBackground),
      child: txt(name: name),
    );
  }

  Widget txt({required String name}) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.only(
            bottom: 5,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.orange, width: 1),
            ),
          ),
          child: Text(
            name,
            style: TextStyles.productForSearchTextStyle,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectedProductsList.removeWhere((element) => element == name);

              if (selectedProductsList.isEmpty) {
                isListNotEmpty = false;
              }
            });
          },
          child: const Icon(
            Icons.close,
            color: AppColors.black,
          ),
        )
      ],
    );
  }

  // Widget productItem(String name) {
  //   return Container(
  //     padding: const EdgeInsets.all(8),
  //     alignment: Alignment.center,
  //     decoration: const BoxDecoration(color: AppColors.orange),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           name,
  //           style: TextStyles.text16white,
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               selectedProductsList.removeWhere((element) => element == name);

  //               if (selectedProductsList.isEmpty) {
  //                 isListNotEmpty = false;
  //               }
  //             });
  //           },
  //           child: const Icon(
  //             Icons.close,
  //             color: AppColors.black,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget products() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        if (productState is ProductLoaded) {
          List<ProductEntity> products = productState.products;
          return Container(
            alignment: Alignment.topCenter,
            child: products.isEmpty ? Container() : productsTextField(products),
          );
        }
        if (productState is ProductFailure) {
          return Container();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget productsTextField(List<ProductEntity> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Autocomplete(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }

          return products.map((e) => e.name).toList().where((element) {
            return element
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          if (selectedProductsList
              .where((element) => element.contains(selection))
              .toList()
              .isEmpty) {
            setState(() {
              isListNotEmpty = true;
              selectedProductsList.add(selection);
            });
          }
        },
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) =>
                TextField(
          style: TextStyles.text16black,
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: "Enter the name of product",
            labelStyle: TextStyles.text16gray,
            suffixIcon: IconButton(
              onPressed: textEditingController.clear,
              icon: const Icon(
                Icons.clear,
                color: AppColors.dirtyGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
