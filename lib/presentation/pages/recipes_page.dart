import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_list.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_search_delegate.dart';

class RecipesPage extends StatefulWidget {
  RecipesPage({
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
    return _builder();
  }

  Widget _builder() {
    return BlocBuilder<RecipeCubit, RecipeState>(
      builder: (context, recipeState) {
        if (recipeState is RecipeLoaded) {
          return _bodyWidget(recipeState.recipes);
        }
        if (recipeState is RecipeFailure) {
          return ErrorPage();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
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
        delegate: RecipeSearchDelegate(),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: recipes.isEmpty ? _noRecipesWidget() : _recipes(),
      ),
    );
  }

  Widget _recipes() {
    return Container(
      child: RecipeList(),
    );
  }
}
