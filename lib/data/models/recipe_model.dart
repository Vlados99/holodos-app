import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/entities/step_entity.dart';
import 'package:holodos/domain/entities/tag_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel({
    required id,
    required name,
    required cuisines,
    required cookTime,
    required complexity,
    required serves,
    required imageLocation,
    required description,
    categories,
    ingredients,
    steps,
    comments,
    tags,
  }) : super(
          id: id,
          name: name,
          cuisines: cuisines,
          cookTime: cookTime,
          complexity: complexity,
          serves: serves,
          imageLocation: imageLocation,
          description: description,
          categories: categories,
          ingredients: ingredients,
          steps: steps,
          comments: comments,
          tags: tags,
        );

  factory RecipeModel.fromSnapshot(
    DocumentSnapshot snapshot, {
    List<ProductEntity>? ingredients,
    List<StepEntity>? steps,
    List<CategoryEntity>? categories,
    List<CommentEntity>? comments,
    List<TagEntity>? tags,
  }) {
    return RecipeModel(
        id: snapshot.id,
        name: snapshot.data().toString().contains('name')
            ? snapshot.get('name')
            : '',
        cuisines: snapshot.data().toString().contains('cuisines')
            ? snapshot.get('cuisines')
            : '',
        cookTime: snapshot.data().toString().contains('cookTime')
            ? snapshot.get('cookTime')
            : 0,
        complexity: snapshot.data().toString().contains('complexity')
            ? snapshot.get('complexity')
            : 0,
        serves: snapshot.data().toString().contains('serves')
            ? snapshot.get('serves')
            : 0,
        imageLocation: snapshot.data().toString().contains('imageLocation')
            ? (snapshot.get("imageLocation")
                    as DocumentReference<Map<String, dynamic>>)
                .id
            : '',
        description: snapshot.data().toString().contains("description")
            ? snapshot.get("description")
            : '',
        categories: categories ?? <CategoryEntity>[],
        ingredients: ingredients ?? <ProductEntity>[],
        steps: steps ?? <StepEntity>[],
        comments: comments ?? <CommentEntity>[],
        tags: tags ?? <TagEntity>[]);
  }

  Map<String, dynamic> toFavoriteRecipe() {
    return {
      'id': id,
      'name': name,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'cuisines': cuisines,
      'cookTime': cookTime,
      'complexity': complexity,
      'serves': serves,
      'imageLocation': imageLocation,
      'description': description,
      'categories': categories,
      'ingredients': ingredients,
      'steps': steps,
      'comments': comments,
      'tags': tags,
    };
  }
}
