import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/data/models/category_model.dart';
import 'package:holodos/data/models/comment_model.dart';
import 'package:holodos/data/models/product_model.dart';
import 'package:holodos/data/models/step_model.dart';
import 'package:holodos/data/models/tag_model.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';
import 'package:holodos/domain/entities/step_entity.dart';
import 'package:holodos/domain/entities/tag_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel(
      {required id,
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
      tags})
      : super(
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
/*
  factory RecipeModel.fromSnapshot(DocumentSnapshot snapshot) {
    return RecipeModel(
      name: snapshot.get('name'),
      cookTime: snapshot.get('cookTime'),
      complexity: snapshot.get('complexity'),
      serves: snapshot.get('serves'),
      categories: snapshot.get('categories'),
      ingredients: snapshot.get('ingredients'),
      steps: snapshot.get('steps'),
      comments: snapshot.get('comments'),
    );
  }
*/

  factory RecipeModel.fromSnapshot(
    DocumentSnapshot snapshot, {
    List<ProductModel>? ingredients,
    List<StepModel>? steps,
    List<CategoryModel>? categories,
    List<CommentModel>? comments,
    List<TagModel>? tags,
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
      tags: tags ?? <TagEntity>[],
    );
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

  //?????????????????????????????????????????????????????????????????
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json["id"],
      name: json["name"],
      cuisines: json["cuisines"],
      cookTime: json["cookTime"],
      complexity: json["complexity"],
      serves: json["serves"],
      imageLocation: json["imageLocation"],
      description: json["description"],
      categories: json["categories"] != null
          ? CategoryModel.fromJson(json['categories'])
          : null,
      ingredients: json["ingridients"] != null
          ? ProductModel.fromJson(json['ingridients'])
          : null,
      steps: json["steps"] != null ? StepModel.fromJson(json['steps']) : null,
      comments: json["comments"] != null
          ? CommentModel.fromJson(json['comments'])
          : null,
      tags: json["tags"] != null ? TagModel.fromJson(json['tags']) : null,
    );
  }
}
