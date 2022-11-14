import 'package:flutter/material.dart';
import 'package:holodos/common/storage.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';

import '../../../common/app_const.dart';

class RecipeItem extends StatefulWidget {
  RecipeEntity recipe;

  RecipeItem({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  double itemHeight = 200;

  @override
  Widget build(BuildContext context) {
    return recipeItem(recipe: widget.recipe);
  }

  Widget recipeItem({required RecipeEntity recipe}) {
    double itemWidth = MediaQuery.of(context).size.width;

    return Container(
      width: itemWidth,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: AppColors.black),
        )),
        alignment: AlignmentDirectional.center,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.orange,
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Text(
                recipe.name,
                style: TextStyles.text32White,
              ),
            ),
            Stack(
              children: [
                Container(
                  child: imageBuilder("recipes", recipe.imageLocation),
                ),
                Container(
                  height: itemHeight,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                      colors: [
                        Colors.white.withOpacity(0.0),
                        AppColors.mainBackground,
                      ],
                      stops: [
                        0.1,
                        0.5,
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: FractionalOffset.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      txt("Cook time: ${recipe.cookTime} min",
                          TextStyles.text16black),
                      txt("Complexity: ${recipe.complexity}",
                          TextStyles.text16black),
                      txt("Serves: ${recipe.serves}", TextStyles.text16black),
                      txt("Cuisines: ${recipe.cuisines}",
                          TextStyles.text16black),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget imageBuilder(String dir, String imgName) {
    return FutureBuilder(
      future: Storage.getImage(dir, imgName),
      builder: ((context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        } else {
          return Image.network(
            snapshot.data!,
            height: itemHeight,
          );
        }
      }),
    );
  }

  Widget txt(String text, TextStyle style) {
    return SizedBox(
      height: 32,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
