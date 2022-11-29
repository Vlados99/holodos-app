import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/appbar/app_bar.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_list.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_search_delegate.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> with RouteAware {
  final GlobalKey<ScaffoldState> _scaffolGlobalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<RecipeCubit>(context).getRecipes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _builder();
  }

  Widget _builder() {
    return BlocBuilder<RecipeCubit, RecipeState>(
      builder: (context, recipeState) {
        if (recipeState is RecipesLoaded) {
          return _bodyWidget(recipeState.recipes);
        }
        if (recipeState is RecipeFailure) {
          return const ErrorPage();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _noRecipesWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Icon(Icons.no_food),
        const Text("Recipes are not found!"),
      ],
    );
  }

  Widget _bodyWidget(List<RecipeEntity> recipes) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SafeArea(
          child: AppDrawer(
        routeName: PageConst.recipesPage,
        width: MediaQuery.of(context).size.width - 80,
      )),
      key: _scaffolGlobalKey,
      appBar: MainAppBar(
        title: "Recipes",
        search: true,
        searchDelegate: RecipeSearchDelegate(),
        filter: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: recipes.isEmpty ? _noRecipesWidget() : _recipes(),
      ),
    );
  }

  Widget _recipes() {
    return const RecipeList();
  }
}
