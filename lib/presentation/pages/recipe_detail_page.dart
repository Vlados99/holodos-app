import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/common/network_status_service.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/entities/step_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';
import 'package:holodos/presentation/cubit/recipe_comments/recipe_comments_cubit.dart';
import 'package:holodos/presentation/pages/error_page.dart';
import 'package:holodos/presentation/widgets/appbar/app_bar.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/image_getter.dart';
import 'package:holodos/presentation/widgets/recipe/recipe_item.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';
import 'package:holodos/presentation/widgets/text_field.dart';

class RecipePage extends StatefulWidget {
  final RecipeEntity recipe;
  final String fromPageName;

  const RecipePage({
    Key? key,
    required this.recipe,
    required this.fromPageName,
  }) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final TextEditingController commentController = TextEditingController();
  final pageName = PageConst.recipePage;

  double itemHeight = 200;
  late RecipeEntity recipe;

  var id = "";
  @override
  void initState() {
    checkConnection(context);

    id = widget.recipe.id;
    recipe = widget.recipe;
    BlocProvider.of<RecipesCubit>(context).getRecipeById(id: id);

    BlocProvider.of<CommentsCubit>(context).getRecipeComments(recipeId: id);
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
      appBar: MainAppBar(
        title: recipe.name,
        leading: true,
        pageName: widget.fromPageName,
      ),
      body: BlocBuilder<RecipesCubit, RecipesState>(
        builder: (context, recipeState) {
          if (recipeState is RecipeLoaded) {
            recipe = recipeState.recipe;
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    RecipeItem(
                      recipe: recipe,
                      pageName: PageConst.recipePage,
                      callback: callback,
                    ),
                    detailRow(),
                    recipeDescription(),
                    recipeProducts(),
                    // recipeCategories(),
                    // recipeTags(),
                    recipeSteps(),
                    recipeComments(),
                  ],
                ),
              ),
            );
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

  Widget detailRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            complexity(),
            cookTime(),
            serves(),
            cuisine(),
          ],
        ),
        divider(),
      ],
    );
  }

  Widget divider() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const Divider(
        color: AppColors.orange,
        thickness: 2,
      ),
    );
  }

  Widget complexity() {
    return Column(
      children: [
        txt16(text: "Complexity"),
        Row(
          children: List.generate(
              recipe.complexity,
              (index) => const Icon(
                    Icons.star,
                    color: AppColors.orange,
                  )).toList(),
        ),
      ],
    );
  }

  Widget cookTime() {
    return Column(
      children: [
        txt16(text: "Time"),
        txt16(text: "${recipe.cookTime} min"),
      ],
    );
  }

  Widget serves() {
    return Column(
      children: [
        txt16(text: "Serves"),
        txt16(text: recipe.serves.toString()),
      ],
    );
  }

  Widget cuisine() {
    return Column(
      children: [
        txt16(text: "Cuisine"),
        txt16(text: recipe.cuisines),
      ],
    );
  }

  Widget recipeDescription() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: txt16(text: recipe.description)),
        divider(),
      ],
    );
  }

  Widget txt32({required String text}) {
    return Text(
      text,
      style: TextStyles.text32black,
    );
  }

  Widget txt24({required String text}) {
    return Text(
      text,
      style: TextStyles.text24black,
    );
  }

  Widget txt16({required String text, TextStyle? style}) {
    return Text(
      text,
      style: style ?? TextStyles.text16black,
    );
  }

  Widget recipeProducts() {
    List<ProductEntity> products = recipe.ingredients!;

    if (products.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: txt32(text: "Ingredients:"),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  ProductEntity product = products[index];

                  String name =
                      product.name[0].toUpperCase() + product.name.substring(1);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ImageGetter(
                      //     dir: "recipes/ingredients/${recipe.name}",
                      //     imgName: product.imageLocation!),
                      txt16(text: "$name - ${product.unit}"),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        divider(),
      ],
    );
  }

  Widget recipeCategories() {
    List<CategoryEntity> categories = recipe.categories!;

    if (categories.isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          txt32(text: "Categories"),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryEntity category = categories[index];

              return txt16(text: category.name);
            },
          ),
        ],
      ),
    );
  }

  Widget recipeSteps() {
    List<StepEntity> steps = recipe.steps!;

    if (steps.isEmpty) {
      return Container();
    }

    return Column(
      children: [
        // txt32("Steps"),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: steps.length,
          itemBuilder: (context, index) {
            StepEntity step = steps[index];

            return Column(
              children: [
                Row(
                  children: [
                    stepNumber(step),
                    stepTitle(step),
                  ],
                ),
                stepImage(step: step),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: txt16(text: step.description),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Divider(
                    indent: MediaQuery.of(context).size.width / 2,
                    color: AppColors.orange,
                    thickness: 10,
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }

  Widget stepImage({required StepEntity step}) {
    if (step.imageLocation == "") {
      return Container();
    }
    return ImageGetter(
        dir: "recipes/steps/${recipe.name}", imgName: step.imageLocation!);
  }

  Widget stepTitle(StepEntity step) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: txt16(text: step.title ?? "", style: TextStyles.text16blackBold),
    );
  }

  Widget stepNumber(StepEntity step) {
    return Align(
      alignment: FractionalOffset.bottomLeft,
      child: Container(
        color: AppColors.orange,
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 10),
          child: txt16(
              text: step.number.toString(), style: TextStyles.text24white),
        ),
      ),
    );
  }

  Widget recipeComments() {
    return BlocBuilder<CommentsCubit, CommentState>(
      builder: (context, commentsState) {
        if (commentsState is CommentsLoaded) {
          return comments(commentsState.comments);
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

  Widget comments(List<CommentEntity> comments) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: txt32(text: "Comments"),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(bottom: 25, left: 10),
          child: Divider(
            endIndent: MediaQuery.of(context).size.width / 2,
            color: AppColors.orange,
            thickness: 4,
          ),
        ),
        postComment(),
        comments.isEmpty
            ? const Text(
                "There are no comments for this recipe yet",
                style: TextStyles.text16gray,
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  CommentEntity comment = comments[index];

                  var date = comment.date.toDate().toLocal();
                  String showDate = "${date.day}.${date.month}.${date.year}";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txt16(text: comment.userName),
                      txt16(
                          // text: comment.date.toDate().toString(),
                          text: showDate,
                          style: TextStyles.text16green),
                      txt16(text: comment.comment),
                    ],
                  );
                },
              ),
      ],
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
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          controller: commentController,
          labelText: "Enter the comment",
        ),
        Container(
          padding: const EdgeInsets.only(right: 16, top: 5),
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

  void callback() {
    BlocProvider.of<RecipesCubit>(context)
        .update(name: pageName, id: recipe.id);
  }
}
