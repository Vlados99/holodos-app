import 'package:flutter/material.dart';
import 'package:holodos/common/storage.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/widgets/sized_box.dart';

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
  double itemHeight = 0;
  double itemWidth = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    itemHeight = 200;
    itemWidth = MediaQuery.of(context).size.width;

    return recipeItem(recipe: widget.recipe);
  }

  Widget recipeItem({required RecipeEntity recipe}) {
    return Container(
      width: itemWidth,
      height: itemHeight + sb_h15().height! + 12,
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: AppColors.orange),
      )),
      child: Column(
        children: [
          sb_h15(),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              recipeImage(recipe),
              gradient(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    recipeName(recipe),
                    saveItButton(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget gradient() {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.0),
            AppColors.black.withOpacity(0.4),
          ],
          stops: const [
            0.1,
            0.8,
          ],
        ),
      ),
    );
  }

  Widget recipeImage(RecipeEntity recipe) {
    return SizedBox(
      height: itemHeight,
      child: imageBuilder("recipes", recipe.imageLocation),
    );
  }

  Widget recipeName(RecipeEntity recipe) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.bottomLeft,
      child: Text(
        recipe.name,
        style: TextStyles.text16white,
      ),
    );
  }

  Widget saveItButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.bottomLeft,
        decoration: const BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(
                Icons.favorite,
                color: AppColors.textColorWhite,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 12),
              child: const Text(
                "SAVE IT",
                style: TextStyles.text12white,
              ),
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
            fit: BoxFit.fill,
            width: itemWidth,
            snapshot.data!,
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
