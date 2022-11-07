import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/common/storage.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/recipe_item.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> with RouteAware {
  GlobalKey<ScaffoldState> _scaffolGlobalKey = GlobalKey<ScaffoldState>();

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
      drawer: SafeArea(
          child: drawer(PageConst.recipesPage,
              MediaQuery.of(context).size.width - 80, context)),
      key: _scaffolGlobalKey,
      appBar: mainAppBar(title: "Recipes"),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.no_food),
        Text("Recipes are not found!"),
      ],
    );
  }

  Widget _bodyWidget(RecipeLoaded recipeLoadedState) {
    return Container(
      alignment: Alignment.topCenter,
      child: recipeLoadedState.recipes.isEmpty
          ? _noRecipesWidget()
          : _recipesList(recipeLoadedState),
    );
  }

  Widget _recipesList(RecipeLoaded recipeLoadedState) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: recipeLoadedState.recipes.length,
        itemBuilder: (_, index) {
          return RecipeItem(
              context: context, state: recipeLoadedState, index: index);
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
        },
      ),
    );
  }
}
