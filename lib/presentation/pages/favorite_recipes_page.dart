import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/common/network_status_service.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/appbar/app_bar.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_list.dart';

class FavoriteRecipesPage extends StatefulWidget {
  const FavoriteRecipesPage({Key? key}) : super(key: key);

  @override
  State<FavoriteRecipesPage> createState() => _FavoriteRecipesPageState();
}

class _FavoriteRecipesPageState extends State<FavoriteRecipesPage> {
  final GlobalKey<ScaffoldState> _scaffolGlobalKey = GlobalKey<ScaffoldState>();

  final pageName = PageConst.favoriteRecipesPage;
  @override
  void initState() {
    checkConnection(context);

    BlocProvider.of<RecipesCubit>(context).getRecipesFromFavorites();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return authState is Authenticated ? _bodyWidget() : notLoggedIn();
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
      appBar: const MainAppBar(
        title: "Favorite recipes",
      ),
      body: centerWidget(
        icon: const Icon(Icons.no_accounts),
        mainText: "Unfortunately, you are not logged in. ",
        buttonText: "Sign in",
        page: PageConst.signInPage,
      ),
    );
  }

  Widget _noRecipesWidget() {
    return centerWidget(
      icon: const Icon(Icons.no_food),
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

  Widget _bodyWidget() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SafeArea(
          child: AppDrawer(
        routeName: pageName,
        width: MediaQuery.of(context).size.width - 80,
      )),
      key: _scaffolGlobalKey,
      appBar: const MainAppBar(title: "Favorite recipes"),
      body: BlocBuilder<RecipesCubit, RecipesState>(
        builder: (context, recipeState) {
          if (recipeState is RecipesLoaded) {
            List<RecipeEntity> recipes = recipeState.recipes;
            return scaffoldBody(recipes);
          }
          if (recipeState is RecipesFailure) {
            return const ErrorPage();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Container scaffoldBody(List<RecipeEntity> recipes) {
    return Container(
      alignment: Alignment.topCenter,
      child: recipes.isEmpty ? _noRecipesWidget() : _recipes(recipes),
    );
  }

  Widget _recipes(List<RecipeEntity> recipes) {
    return RecipeList(
      pageName: pageName,
      recipes: recipes,
      callback: callback,
    );
  }

  void callback() {
    setState(() {});
    BlocProvider.of<RecipesCubit>(context).update(name: pageName);
  }
}
