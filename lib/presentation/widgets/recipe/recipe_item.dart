import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/common/storage.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/widgets/image_getter.dart';
import 'package:holodos/presentation/widgets/sized_box.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';

class RecipeItem extends StatefulWidget {
  final RecipeEntity recipe;
  final String pageName;
  Function callback;

  RecipeItem({
    Key? key,
    required this.recipe,
    required this.pageName,
    required this.callback,
  }) : super(key: key);

  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  double itemHeight = 0;
  double itemWidth = 0;
  late RecipeEntity recipe;
  late bool isFavorite;

  @override
  void initState() {
    recipe = widget.recipe;
    isFavorite = recipe.isFavorite ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    itemHeight = 200;
    itemWidth = MediaQuery.of(context).size.width;
    final h15 = CustomSizedBox().h15();
    return SizedBox(
      width: itemWidth,
      height: itemHeight + h15.height! + 12,
      child: Column(
        children: [
          h15,
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
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, authState) {
                        return authState is Authenticated
                            ? saveItButton()
                            : Container();
                      },
                    )
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
            AppColors.black.withOpacity(0.7),
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
      child: ImageGetter(
        dir: "recipes",
        imgName: recipe.imageLocation,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
      ),
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
      onTap: () {
        isFavorite ? removeRecipeFromFavorites() : addRecipeToFavorites();
        widget.callback();

        // if (widget.pageName == PageConst.recipesPage) {
        //   BlocProvider.of<RecipesCubit>(context).getRecipes();
        // }
        // if (widget.pageName == PageConst.favoriteRecipesPage && isFavorite) {
        //   BlocProvider.of<RecipesCubit>(context).getRecipesFromFavorites();
        // }
      },
      child: isFavorite ? favorite() : notFavorite(),
    );
  }

  void removeRecipeFromFavorites() {
    BlocProvider.of<RecipesCubit>(context)
        .removeRecipeFromFavorites(recipe: recipe);
    snackBarSuccess(context: context, message: "Recipe removed from favorites");
  }

  void addRecipeToFavorites() {
    BlocProvider.of<RecipesCubit>(context).addRecipeToFavorites(recipe: recipe);
    snackBarSuccess(
        context: context,
        message: "The recipe has been successfully added to your favorites");
  }

  Widget favorite() {
    return Container(
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
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget notFavorite() {
    return Container(
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
