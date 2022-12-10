import 'package:flutter/material.dart';

import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_item.dart';

class RecipeList extends StatefulWidget {
  final List<RecipeEntity> recipes;
  final String pageName;
  Function callback;

  RecipeList({
    Key? key,
    required this.recipes,
    required this.pageName,
    required this.callback,
  }) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  List<RecipeEntity> recipes = [];

  @override
  void initState() {
    recipes = widget.recipes;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, PageConst.recipePage, ((route) => true), arguments: {
              "recipe": recipes[index],
              "pageName": widget.pageName
            });
          },
          child: Column(
            children: [
              RecipeItem(
                recipe: recipes[index],
                pageName: widget.pageName,
                callback: () => widget.callback(),
              ),
              const Divider(
                color: AppColors.orange,
                thickness: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
