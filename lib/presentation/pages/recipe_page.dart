import 'package:flutter/material.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';

class RecipePage extends StatefulWidget {
  final RecipeEntity recipe;

  const RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.recipe.name}")),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: widget.recipe.ingredients?.length,
          itemBuilder: (context, index) {
            return Container(
              height: 40,
              child: Text(
                  "${widget.recipe.ingredients![index].name} - ${widget.recipe.ingredients![index].unit}"),
            );
          },
        ),
      ),
    );
  }
}
