import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/entities/step_entity.dart';
import 'package:holodos/domain/entities/tag_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/recipe_comments/recipe_comments_cubit.dart';
import 'package:holodos/presentation/widgets/appbar/app_bar.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/sized_box.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';
import 'package:holodos/presentation/widgets/text_field.dart';

class RecipePage extends StatefulWidget {
  final RecipeEntity recipe;

  const RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final TextEditingController commentController = TextEditingController();

  late RecipeEntity recipe;
  @override
  void initState() {
    recipe = widget.recipe;

    BlocProvider.of<CommentsCubit>(context)
        .getRecipeComments(recipeId: recipe.id);
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: recipe.name),
      body: scaffoldBody(),
    );
  }

  Widget scaffoldBody() {
    final h15 = CustomSizedBox().h15();

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(children: [
          const Text(
            "Products",
            style: TextStyles.text32black,
          ),
          recipeProducts(),
          h15,
          const Text(
            "categories",
            style: TextStyles.text32black,
          ),
          recipeCategories(),
          h15,
          const Text(
            "steps",
            style: TextStyles.text32black,
          ),
          recipeSteps(),
          h15,
          const Text(
            "tags",
            style: TextStyles.text32black,
          ),
          recipeTags(),
          h15,
          const Text(
            "comments",
            style: TextStyles.text32black,
          ),
          recipeComments(),
          postComment(),
        ]),
      ),
    );
  }

  Widget recipeProducts() {
    List<ProductEntity> products = recipe.ingredients!;

    if (products.isEmpty) {
      return Container();
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductEntity product = products[index];

        return Text("${product.name} - ${product.unit}");
      },
    );
  }

  Widget recipeCategories() {
    List<CategoryEntity> categories = recipe.categories!;

    if (categories.isEmpty) {
      return Container();
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        CategoryEntity category = categories[index];
        return Text(category.name);
      },
    );
  }

  Widget recipeComments() {
    return BlocBuilder<CommentsCubit, CommentState>(
      builder: (context, commentsState) {
        if (commentsState is CommentsLoaded) {
          return listView(commentsState.comments);
        }
        if (commentsState is CommentFailure) {
          return Container();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  ListView listView(List<CommentEntity> comments) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        CommentEntity comment = comments[index];
        return Column(
          children: [
            Text(comment.userName),
            Text(comment.comment),
            Text(comment.date.toDate().toString()),
          ],
        );
      },
    );
  }

  Widget recipeSteps() {
    List<StepEntity> steps = recipe.steps!;

    if (steps.isEmpty) {
      return Container();
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        StepEntity step = steps[index];
        return Column(
          children: [
            Text(step.number.toString()),
            Text(step.title ?? ""),
            Text(step.description),
            Text(step.imageLocation ?? ""),
          ],
        );
      },
    );
  }

  Widget recipeTags() {
    List<TagEntity> tags = recipe.tags!;

    if (tags.isEmpty) {
      return Container();
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: tags.length,
      itemBuilder: (context, index) {
        TagEntity tag = tags[index];
        return Text(tag.name);
      },
    );
  }

  Widget postComment() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return authState is Authenticated ? postCommentDetail() : Container();
      },
    );
  }

  Widget postCommentDetail() {
    return Column(
      children: [
        SimpleTextField(
          controller: commentController,
          labelText: "Enter the comment",
        ),
        Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  submitAddComment();
                },
                child: Button(
                  text: "Comment",
                  backgroundColor: AppColors.button,
                  fontColor: AppColors.textColorWhite,
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void submitAddComment() {
    final commentContent = commentController.text;
    if (commentContent.isNotEmpty) {
      BlocProvider.of<CommentsCubit>(context)
          .commentOnRecipe(comment: commentContent, recipe: recipe);
      snackBarSuccess(context: context, message: "Comment added successfully");
    } else {
      snackBarError(context: context, message: "Enter the value to text field");
    }

    commentController.clear();
  }
}
