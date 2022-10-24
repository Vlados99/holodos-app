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
  final List<Category> catigories;
  final List<Product> ingredients;
  final List<Step> steps;
  final List<Comment>? comments;

  RecipeEntity(
      {required this.id,
      required this.name,
      required this.cookTime,
      required this.howEasy,
      required this.serves,
      required this.catigories,
      required this.ingredients,
      required this.steps,
      this.comments});

  @override
  List<Object?> get props => [
        id,
        name,
        cookTime,
        howEasy,
        serves,
        catigories,
        ingredients,
        steps,
        comments
      ];
}
