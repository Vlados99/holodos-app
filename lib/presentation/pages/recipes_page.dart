import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';

class RecipesPage extends StatefulWidget {
  final String uId;
  const RecipesPage({Key? key, required this.uId}) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  @override
  void initState() {
    BlocProvider.of<RecipeCubit>(context).getRecipes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
            },
            icon: Icon(Icons.exit_to_app),
            color: Colors.white,
          ),
        ],
      ),
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, recipeState) {
          if (recipeState is RecipeLoaded) {
            return _bodyWidget(recipeState);
          }
          if (recipeState is RecipeFailure) {
            return ErrorPage();
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _noRecipesWidget() {
    return Column(
      children: [
        Icon(Icons.no_food),
        Text("Recipes are not found!"),
      ],
    );
  }

  Widget _bodyWidget(RecipeLoaded recipeLoadedState) {
    return Container(
      child: recipeLoadedState.recipes.isEmpty
          ? _noRecipesWidget()
          : _recipesList(recipeLoadedState),
    );
  }

  Widget _recipesList(RecipeLoaded recipeLoadedState) {
    return GridView.builder(
      itemCount: recipeLoadedState.recipes.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PageConst.recipePage,
                arguments: recipeLoadedState.recipes[index]);
          },
          /* ADD THIS FUNCTIONAL TO FAVORITES RECIPES FOR USER
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Remove recipe"),
                  content:
                      const Text("Do you really want to remove this recipe?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        /* BlocProvider.of<RecipeCubit>(context)
                            .removeRecipeFromFavorites();
                            
                            REMOVE RECIPE FROM FAVORITES
                            */
                        Navigator.pop(context);
                      },
                      child: const Text("Remove"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("No"),
                    ),
                  ],
                );
              },
            );
          },*/
          child: Container(
            alignment: AlignmentDirectional.center,
            child: Column(
              children: [
                Text(
                  "${recipeLoadedState.recipes[index].name}",
                  style: CustomTextStyle.text32s,
                ),
                SizedBox(
                  height: 15,
                ),
                txt("Cook time: ${recipeLoadedState.recipes[index].cookTime} min",
                    CustomTextStyle.text16s),
                SizedBox(
                  height: 8,
                ),
                txt("How easy: ${recipeLoadedState.recipes[index].howEasy}",
                    CustomTextStyle.text16s),
                SizedBox(
                  height: 8,
                ),
                txt("Serves: ${recipeLoadedState.recipes[index].serves}",
                    CustomTextStyle.text16s),
                SizedBox(
                  height: 8,
                ),
                txt("imageU: ${recipeLoadedState.recipes[index].imageUri}",
                    CustomTextStyle.text16s),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget txt(String text, TextStyle style) {
    return Text(
      text,
      style: style,
    );
  }
}
