import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_item.dart';

import '../../../common/storage.dart';

class RecipeList extends StatefulWidget {
  final List<RecipeEntity>? recipes;
  RecipeList({
    Key? key,
    this.recipes,
  }) : super(key: key);

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    final recipes = widget.recipes;
    return BlocBuilder<RecipeCubit, RecipeState>(builder: (context, state) {
      if (state is RecipeLoaded) {
        return listView(recipes ?? state.recipes);
      }
      if (state is RecipeFailure) {
        return ErrorPage();
      }

      return const Center(child: CircularProgressIndicator());
    });
  }

  ListView listView(List<RecipeEntity> recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PageConst.recipePage,
                arguments: recipes[index]);
          },
          child: RecipeItem(
            recipe: recipes[index],
          ),
        );
      },
    );
  }
}
