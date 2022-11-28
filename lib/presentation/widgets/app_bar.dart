import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';

import 'package:holodos/presentation/cubit/cuisine/cuisine_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';

double _appbarHeight = 56;

int complexityValue = 0;
int cookTimeValue = 0;
String cookTimeSymbol = "All";
String cuisinesValue = "All";
int servesValue = 0;

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  bool? search;
  SearchDelegate? searchDelegate;

  bool? filter;

  MainAppBar({
    Key? key,
    this.title,
    this.search = false,
    this.searchDelegate,
    this.filter = false,
  }) : super(key: key);

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_appbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        widget.title ?? '',
        style: TextStyles.appBarTextStyle,
      ),
      actions: [
        widget.filter!
            ? GestureDetector(
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
              )
            : Container(),
        widget.search!
            ? GestureDetector(
                onTap: () {
                  showSearch(
                      context: context, delegate: widget.searchDelegate!);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.search,
                    color: AppColors.dirtyGreen,
                  ),
                ),
              )
            : Container(),
      ],
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
                    name: "Cook time", widget: const CookTimeDropdownButton()),
                filterItem(
                    name: "Complexity",
                    widget: const ComplexityDropdownButton()),
                filterItem(
                    name: "Serves", widget: const ServerDropdownButton()),
                filterItem(
                    name: "Cuisines", widget: const CuisinesDropdownButton()),
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
                    "cookTimeSymbol": cookTimeSymbol,
                    "cuisines": cuisinesValue == "All" ? null : cuisinesValue,
                    "serves": servesValue == 0 ? null : servesValue,
                  };

                  BlocProvider.of<RecipeCubit>(context)
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
}

class ComplexityDropdownButton extends StatefulWidget {
  const ComplexityDropdownButton({super.key});

  @override
  State<ComplexityDropdownButton> createState() =>
      _ComplexityDropdownButtonState();
}

class _ComplexityDropdownButtonState extends State<ComplexityDropdownButton> {
  String dropdownValue = "";

  List<String> items = ["All", "1", "2", "3", "4", "5"];
  @override
  void initState() {
    complexityValue = 0;
    dropdownValue = items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        complexityValue = int.tryParse(value!) ?? 0;
        setState(() {
          dropdownValue = value;
        });
      },
      items: items
          .map<DropdownMenuItem<String>>((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );
  }
}

class CookTimeDropdownButton extends StatefulWidget {
  const CookTimeDropdownButton({Key? key}) : super(key: key);

  @override
  State<CookTimeDropdownButton> createState() => _CookTimeDropdownButtonState();
}

class _CookTimeDropdownButtonState extends State<CookTimeDropdownButton> {
  String dropdownValue = "";

  List<String> items = ["All", "< 30 min", "> 30 min", "> 60 min"];
  @override
  void initState() {
    cookTimeValue = 0;
    dropdownValue = items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        cookTimeSymbol = value!.split(" ").first;
        cookTimeValue = int.tryParse(value.split(" ").elementAt(1)) ?? 0;
        setState(() {
          dropdownValue = value;
        });
      },
      items: items
          .map<DropdownMenuItem<String>>((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );
  }
}

class CuisinesDropdownButton extends StatefulWidget {
  const CuisinesDropdownButton({Key? key}) : super(key: key);

  @override
  State<CuisinesDropdownButton> createState() => _CuisinesDropdownButtonState();
}

class _CuisinesDropdownButtonState extends State<CuisinesDropdownButton> {
  String dropdownValue = "";

  List<String> items = ["All"];

  @override
  void initState() {
    BlocProvider.of<CuisineCubit>(context).getCuisines();

    cuisinesValue = "";
    dropdownValue = items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CuisineCubit, CuisineState>(
      builder: (context, cuisineState) {
        if (cuisineState is CuisineLoaded) {
          return dropdownMenu(
              cuisineState.cuisines.map((e) => e.name).toList());
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  DropdownButton<String> dropdownMenu(List<String> cuisines) {
    items = ["All"] + cuisines;
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        cuisinesValue = value!;
        setState(() {
          dropdownValue = value;
        });
      },
      items: items
          .map<DropdownMenuItem<String>>((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );
  }
}

class ServerDropdownButton extends StatefulWidget {
  const ServerDropdownButton({Key? key}) : super(key: key);

  @override
  State<ServerDropdownButton> createState() => _ServerDropdownButtonState();
}

class _ServerDropdownButtonState extends State<ServerDropdownButton> {
  String dropdownValue = "";

  List<String> items = ["All", "1", "2", "3 +"];
  @override
  void initState() {
    servesValue = 0;
    dropdownValue = items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        servesValue = int.tryParse(value!.split(" ").first) ?? 0;
        setState(() {
          dropdownValue = value;
        });
      },
      items: items
          .map<DropdownMenuItem<String>>((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );
  }
}
