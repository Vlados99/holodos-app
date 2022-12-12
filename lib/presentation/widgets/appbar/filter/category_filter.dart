import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/presentation/cubit/category/category_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';

class CategoriesFilter extends StatefulWidget {
  const CategoriesFilter({Key? key}) : super(key: key);

  @override
  State<CategoriesFilter> createState() => _CategoriesFilterState();
}

class _CategoriesFilterState extends State<CategoriesFilter> {
  List<String> items = [];

  List<CategoryEntity> categories = [];
  @override
  void initState() {
    BlocProvider.of<CategoryCubit>(context).getCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, categoryState) {
        if (categoryState is CategoryLoaded) {
          categories = categoryState.categories;
          return body();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget body() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Category",
                style: TextStyles.text16black,
              ),
            ),
            GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: categories.map((e) {
                  return categoryItem(e);
                }).toList()),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(CategoryEntity category) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<RecipesCubit>(context)
            .searchRecipesByCategories(category: category);
        Navigator.of(context).pop();
      },
      child: Container(
        height: 35,
        decoration: const BoxDecoration(
            color: AppColors.dirtyGreen,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        alignment: Alignment.center,
        child: Text(
          category.name,
          style: TextStyles.text16white,
        ),
      ),
    );
  }
}
