import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_list.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_search_delegate.dart';

class FavoriteRecipesPage extends StatefulWidget {
  @override
  State<FavoriteRecipesPage> createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  GlobalKey<ScaffoldState> _scaffolGlobalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<RecipeCubit>(context).getRecipesFromFavorites();

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

        return const Center(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Do you have any favorite recipes? ",
              style: TextStyles.text16black,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.recipesPage, (route) => false);
              },
              child: Button(
                width: 90,
                context: context,
                text: "Add them!",
                fontColor: AppColors.textColorDirtyGreen,
              ),
            ),
          ],
        ),
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
              context: context)),
      key: _scaffolGlobalKey,
      appBar: MainAppBar(
        title: "Favorite recipes",
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
