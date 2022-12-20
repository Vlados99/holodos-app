import 'package:equatable/equatable.dart';

import 'category_entity.dart';
import 'comment_entity.dart';
import 'product_entity.dart';
import 'step_entity.dart';

class RecipeEntity extends Equatable {
  final String id;
  final String name;
  final String cuisines;
  final int cookTime;
  final int complexity;
  final int serves;
  final String imageLocation;
  final String description;
  final List<CategoryEntity>? categories;
  final List<ProductEntity>? ingredients;
  final List<StepEntity>? steps;
  final List<CommentEntity>? comments;
  bool? isFavorite;

  RecipeEntity({
    required this.id,
    required this.name,
    required this.cuisines,
    required this.cookTime,
    required this.complexity,
    required this.serves,
    required this.imageLocation,
    required this.description,
    this.categories,
    this.ingredients,
    this.steps,
    this.comments,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        cuisines,
        cookTime,
        complexity,
        serves,
        imageLocation,
        description,
        categories,
        ingredients,
        steps,
        comments,
        isFavorite,
      ];
}
