import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
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
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Filter for recipes"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                      onChanged: (value) => cuisinesValue = value,
                    )),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> params = {
                    "complexity": complexityValue == 0 ? null : complexityValue,
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
                child: const Text("Enter"),
              ),
            ],
          );
        });
  }

  Widget filterItem({required String name, required StatefulWidget widget}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          SizedBox(width: 100, child: widget),
        ],
      );
  // bool isEmpty() {
  //   if (servesValue != 0 ||
  //       complexityValue != 0 ||
  //       (cookTimeValue != 0 && cookTimeSymbol != "All") ||
  //       cuisinesValue != "All") {
  //     return true;
  //   }

  //   return false;
  // }
}
