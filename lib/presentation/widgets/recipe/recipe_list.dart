import 'package:flutter/material.dart';

import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_item.dart';

class RecipeList extends StatefulWidget {
  final List<RecipeEntity> recipes;
  final String pageName;
  const RecipeList({
    Key? key,
    required this.recipes,
    required this.pageName,
  }) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    final recipes = widget.recipes;

    return listView(recipes: recipes);
  }

  ListView listView({required List<RecipeEntity> recipes}) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, PageConst.recipePage, ((route) => true), arguments: {
              "id": recipes[index].id,
              "isFavorite": recipes[index].isFavorite
            });
          },
          child: Column(
            children: [
              RecipeItem(
                recipe: recipes[index],
                pageName: widget.pageName,
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
