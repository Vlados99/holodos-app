import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/widgets/appbar/filter/category_filter.dart';
import 'package:holodos/presentation/widgets/appbar/filter/complexity_filter.dart';
import 'package:holodos/presentation/widgets/appbar/filter/cook_time_filter.dart';
import 'package:holodos/presentation/widgets/appbar/filter/cuisines_filter.dart';
import 'package:holodos/presentation/widgets/appbar/filter/serves_filter.dart';

class FilterAppBarItem extends StatefulWidget {
  const FilterAppBarItem({Key? key}) : super(key: key);

  @override
  State<FilterAppBarItem> createState() => _FilterAppBarItemState();
}

class _FilterAppBarItemState extends State<FilterAppBarItem> {
  int complexityValue = 0;
  int servesValue = 0;
  int cookTimeValue = 0;

  String cookTimeSymbol = "All";
  String cuisinesValue = "All";
  String categoriesValue = "All";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showFilter(context: context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: AppColors.dirtyGreen),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              "Filter",
              style: TextStyles.text16white,
            ),
          ),
        ],
      ),
    );
  }

  void showFilter({required BuildContext context}) {
    complexityValue = 0;
    servesValue = 0;
    cookTimeValue = 0;

    cookTimeSymbol = "All";
    cuisinesValue = "All";
    categoriesValue = "All";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                "Filter for recipes",
                style: TextStyles.text16blackBold,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CategoriesFilter(),
                filterItem(
                    name: "Cook time",
                    widget: CookTimeDropdownButton(
                      onSymbolChanged: (value) => cookTimeSymbol = value,
                      onValueChanged: (value) => cookTimeValue = value,
                    )),
                filterItem(
                    name: "Complexity",
                    widget: ComplexityDropdownButton(
                      onChanged: (value) => complexityValue = value,
                    )),
                filterItem(
                    name: "Serves",
                    widget: ServesDropdownButton(
                      onChanged: (value) => servesValue = value,
                    )),
                filterItem(
                    name: "Cuisines",
                    widget: CuisinesDropdownButton(
                      onChanged: (value) {
                        cuisinesValue = value;
                      },
                    )),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyles.text16white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: GestureDetector(
                  onTap: () {
                    Map<String, dynamic> params = {
                      "complexity":
                          complexityValue == 0 ? null : complexityValue,
                      "cookTime": cookTimeValue == 0 ? null : cookTimeValue,
                      "cookTimeSymbol":
                          cookTimeSymbol == "All" ? null : cookTimeSymbol,
                      "cuisines": cuisinesValue == "All" ? null : cuisinesValue,
                      "serves": servesValue == 0 ? null : servesValue,
                    };

                    BlocProvider.of<RecipesCubit>(context)
                        .getRecipes(recipeParams: params);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Enter",
                      style: TextStyles.text16white,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget filterItem({required String name, required StatefulWidget widget}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyles.text16black,
          ),
          SizedBox(width: 100, child: widget),
        ],
      );
}
