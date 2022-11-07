import 'package:equatable/equatable.dart';

import 'category_entity.dart';
import 'comment_entity.dart';
import 'product_entity.dart';
import 'step_entity.dart';
import 'tag_entity.dart';

class RecipeEntity extends Equatable {
  final String id;
  final String name;
  final String cuisines;
  final int cookTime;
  final int complexity;
  final int serves;
  final String imgUri;
  final List<CategoryEntity>? categories;
  final List<ProductEntity>? ingredients;
  final List<StepEntity>? steps;
  final List<CommentEntity>? comments;
  final List<TagEntity>? tags;

  const RecipeEntity(
      {required this.id,
      required this.name,
      required this.cuisines,
      required this.cookTime,
      required this.complexity,
      required this.serves,
      required this.imgUri,
      this.categories,
      this.ingredients,
      this.steps,
      this.comments,
      this.tags});

  @override
  List<Object?> get props => [
        id,
        name,
        cuisines,
        cookTime,
        complexity,
        serves,
        imgUri,
        categories,
        ingredients,
        steps,
        comments,
        tags,
      ];
}
