import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/entities/step_entity.dart';
import 'package:holodos/domain/entities/tag_entity.dart';
import 'package:holodos/presentation/widgets/sized_box.dart';

class RecipePage extends StatefulWidget {
  final RecipeEntity recipe;

  const RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  late RecipeEntity recipe;
  @override
  void initState() {
    recipe = widget.recipe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: scaffoldBody(),
    );
  }

  Widget scaffoldBody() {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(children: [
          const Text(
            "Products",
            style: TextStyles.text32black,
          ),
          recipeProducts(),
          sb_h15(),
          const Text(
            "categories",
            style: TextStyles.text32black,
          ),
          recipeCategories(),
          sb_h15(),
          const Text(
            "comments",
            style: TextStyles.text32black,
          ),
          recipeComments(),
          sb_h15(),
          const Text(
            "steps",
            style: TextStyles.text32black,
          ),
          recipeSteps(),
          sb_h15(),
          const Text(
            "tags",
            style: TextStyles.text32black,
          ),
          recipeTags(),
        ]),
      ),
    );
  }

  Widget recipeProducts() {
    List<ProductEntity> products = recipe.ingredients!;

    if (products.isEmpty) {
      return Container();
    }

    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: products.length,
        itemBuilder: (context, index) {
          ProductEntity product = products[index];

          return Container(
            child: Text("${product.name} - ${product.unit}"),
          );
        },
      ),
    );
  }

  Widget recipeCategories() {
    List<CategoryEntity> categories = recipe.categories!;

    if (categories.isEmpty) {
      return Container();
    }

    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          CategoryEntity category = categories[index];
          return Container(
            child: Text(category.name),
          );
        },
      ),
    );
  }

  Widget recipeComments() {
    List<CommentEntity> comments = recipe.comments!;

    if (comments.isEmpty) {
      return Container();
    }

    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          CommentEntity comment = comments[index];
          return Column(
            children: [
              Container(
                child: Text(comment.userName),
              ),
              Container(
                child: Text(comment.comment),
              ),
              Container(
                child: Text(comment.date.toString()),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget recipeSteps() {
    List<StepEntity> steps = recipe.steps!;

    if (steps.isEmpty) {
      return Container();
    }

    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          StepEntity step = steps[index];
          return Column(
            children: [
              Container(
                child: Text(step.number.toString()),
              ),
              Container(
                child: Text(step.title ?? ""),
              ),
              Container(
                child: Text(step.description),
              ),
              Container(
                child: Text(step.imageLocation ?? ""),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget recipeTags() {
    List<TagEntity> tags = recipe.tags!;

    if (tags.isEmpty) {
      return Container();
    }

    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(8),
        itemCount: tags.length,
        itemBuilder: (context, index) {
          TagEntity tag = tags[index];
          return Container(
            child: Text(tag.name),
          );
        },
      ),
    );
  }
}
