import 'package:equatable/equatable.dart';

import 'category_entity.dart';
import 'comment_entity.dart';
import 'product_entity.dart';
import 'step_entity.dart';

class RecipeEntity extends Equatable {
  final String id;
  final String name;
  final int cookTime; // in minutes
  final int howEasy; // 1 to 5
  final int serves;
  final String imageUri;
  final List<CategoryEntity>? categories;
  final List<ProductEntity>? ingredients;
  final List<StepEntity>? steps;
  final List<CommentEntity>? comments;

  const RecipeEntity({
    required this.id,
    required this.name,
    required this.cookTime,
    required this.howEasy,
    required this.serves,
    required this.imageUri,
    required this.categories,
    required this.ingredients,
    required this.steps,
    this.comments,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        cookTime,
        howEasy,
        serves,
        imageUri,
        categories,
        ingredients,
        steps,
        comments
      ];
}
