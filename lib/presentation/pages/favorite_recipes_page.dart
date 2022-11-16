import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
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
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return authState is Authenticated ? recipeBuilder() : notLoggedIn();
      },
    );
  }

  Widget notLoggedIn() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SafeArea(
          child: AppDrawer(
        routeName: PageConst.favoriteRecipesPage,
        width: MediaQuery.of(context).size.width - 80,
      )),
      key: _scaffolGlobalKey,
      appBar: MainAppBar(
        title: "Favorite recipes",
      ),
      body: centerWidget(
        icon: Icon(Icons.no_accounts),
        mainText: "Unfortunately, you are not logged in. ",
        buttonText: "Sign in",
        page: PageConst.signInPage,
      ),
    );
  }

  BlocBuilder<RecipeCubit, RecipeState> recipeBuilder() {
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
    return centerWidget(
      icon: Icon(Icons.no_food),
      mainText: "Do you have any favorite recipes? ",
      buttonText: "Add them!",
      page: PageConst.recipesPage,
    );
  }

  Widget centerWidget({
    required Icon icon,
    required String mainText,
    required String buttonText,
    required String page,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mainText,
              style: TextStyles.text16black,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, page, (route) => false);
              },
              child: Button(
                text: buttonText,
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
        routeName: PageConst.favoriteRecipesPage,
        width: MediaQuery.of(context).size.width - 80,
      )),
      key: _scaffolGlobalKey,
      appBar: MainAppBar(
        title: "Favorite recipes",
        search: true,
        delegate: RecipeSearchDelegate(),
      ),
      body: scaffoldBody(recipes),
    );
  }

  Container scaffoldBody(List<RecipeEntity> recipes) {
    return Container(
      alignment: Alignment.topCenter,
      child: recipes.isEmpty ? _noRecipesWidget() : _recipes(),
    );
  }

  Widget _recipes() {
    return Container(
      child: RecipeList(),
    );
  }
}
