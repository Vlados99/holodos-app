import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/appbar/app_bar.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/drawer.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_list.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_search_delegate.dart';
import 'package:holodos/presentation/widgets/text_field.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> with RouteAware {
  final TextEditingController productController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffolGlobalKey = GlobalKey<ScaffoldState>();
  final pageName = PageConst.recipesPage;

  @override
  void dispose() {
    productController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<RecipesCubit>(context).getRecipes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _builder();
  }

  Widget _builder() {
    return BlocBuilder<RecipesCubit, RecipesState>(
      builder: (context, recipeState) {
        if (recipeState is RecipesLoaded) {
          return _bodyWidget(recipeState.recipes);
        }
        if (recipeState is RecipesFailure) {
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
      children: const [
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
        routeName: pageName,
        width: MediaQuery.of(context).size.width - 80,
      )),
      key: _scaffolGlobalKey,
      appBar: MainAppBar(
        title: "Recipes",
        search: true,
        searchDelegate: RecipeSearchDelegate(pageName: pageName),
        filter: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: recipes.isEmpty ? _noRecipesWidget() : _recipes(recipes),
      ),
    );
  }

  Widget _recipes(List<RecipeEntity> recipes) {
    return Column(
      children: [
        searchByProducts(),
        Expanded(
          child: RecipeList(
            pageName: pageName,
            recipes: recipes,
          ),
        ),
      ],
    );
  }

  Widget searchByProducts() {
    return Container(
      child: Column(
        children: [
          products(),
          selectedProducts(),
          searchButton(),
        ],
      ),
    );
  }

  Widget searchButton() {
    return Button(
      text: "Search",
      backgroundColor: AppColors.dirtyGreen,
      fontColor: AppColors.textColorWhite,
      width: MediaQuery.of(context).size.width / 3,
    );
  }

  Widget selectedProducts() {
    return Text("products list");
  }

  Widget products() {
    return Column(
      children: [
        SearchTextField(
          context: context,
          controller: productController,
        ),
      ],
    );
  }
}
