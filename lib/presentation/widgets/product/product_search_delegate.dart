import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/presentation/bloc/search_product/search_product_bloc.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/product/product_search_result.dart';

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
  List<Widget>? buildActions(BuildContext context) {
    return [
      GestureDetector(
        onTap: () {
          query = '';
          showSuggestions(context);
        },
        child: const Icon(
          Icons.clear,
          color: AppColors.dirtyGreen,
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
      ..add(SearchProductsByNameBloc(query));
    return BlocBuilder<SearchProductBloc, SearchProductState>(
        builder: (context, state) {
      if (state is SearchProductLoaded) {
        final product = state.products;
        return Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              ProductEntity result = product[index];
              return ProductItem(
                name: result.name,
              );
            },
            itemCount: product.isNotEmpty ? product.length : 0,
          ),
        );
      } else if (state is SearchProductFailure) {
        return ErrorPage();
      }

      return Center(
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
          return Text(
            _suggestions[index],
            style: TextStyles.text16black,
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _suggestions.length);
  }
}
