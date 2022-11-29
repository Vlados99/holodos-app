import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/bloc/search_product/search_product_bloc.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/product/product_list.dart';

class ProductSearchDelegate extends SearchDelegate {
  ProductSearchDelegate() : super(searchFieldLabel: 'Enter product name');

  final _suggestions = [
    "Salt",
    "Olive oil",
    "Flour",
    "Onion",
    "Egg",
  ];

  @override
  TextStyle? get searchFieldStyle => TextStyles.text16black;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.light();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(
        padding: const EdgeInsets.only(right: 12),
        child: GestureDetector(
          onTap: () {
            query = '';
            showSuggestions(context);
          },
          child: const Icon(
            Icons.clear,
            color: AppColors.dirtyGreen,
          ),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      child: const Icon(
        Icons.arrow_back_ios_new_outlined,
        color: AppColors.dirtyGreen,
      ),
      onTap: () {
        return close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<SearchProductBloc>(context, listen: false)
        .add(SearchProductsByNameBloc(query));
    return BlocBuilder<SearchProductBloc, SearchProductState>(
        builder: (context, state) {
      if (state is SearchProductLoaded) {
        final products = state.products;
        return ProductList(
          products: products,
        );
      } else if (state is SearchProductFailure) {
        return const ErrorPage();
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }

    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              query = _suggestions[index];
            },
            child: Container(
              padding: const EdgeInsets.only(left: 24, top: 12, bottom: 12),
              child: Text(
                _suggestions[index],
                style: TextStyles.text16black,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: _suggestions.length);
  }
}
