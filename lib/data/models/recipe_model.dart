import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/data/models/category_model.dart';
import 'package:holodos/data/models/comment_model.dart';
import 'package:holodos/data/models/product_model.dart';
import 'package:holodos/data/models/step_model.dart';
import 'package:holodos/data/models/tag_model.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel(
      {required id,
      required name,
      required cookTime,
      required complexity,
      required serves,
      required imgUri,
      categories,
      ingredients,
      steps,
      comments,
      tags})
      : super(
          id: id,
          name: name,
          cookTime: cookTime,
          complexity: complexity,
          serves: serves,
          imgUri: imgUri,
          categories: categories,
          ingredients: ingredients,
          steps: steps,
          comments: comments,
          tags: tags,
        );
/*
  factory RecipeModel.fromSnapshot(DocumentSnapshot snapshot) {
    return RecipeModel(
      id: snapshot.get('id'),
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
      id: snapshot.data().toString().contains('id') ? snapshot.get('id') : '',
      name: snapshot.data().toString().contains('name')
          ? snapshot.get('name')
          : '',
      cookTime: snapshot.data().toString().contains('cookTime')
          ? snapshot.get('cookTime')
          : '',
      complexity: snapshot.data().toString().contains('complexity')
          ? snapshot.get('complexity')
          : '',
      serves: snapshot.data().toString().contains('serves')
          ? snapshot.get('serves')
          : '',
      imgUri: snapshot.data().toString().contains('imgUri')
          ? snapshot.get("imgUri").toString()
          : '',
      categories: categories ?? '',
      ingredients: ingredients ?? '',
      steps: steps ?? '',
      comments: comments ?? '',
      tags: tags ?? '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'cookTime': cookTime,
      'complexity': complexity,
      'serves': serves,
      'imgUri': imgUri,
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
      id: json["_id"],
      name: json["name"],
      cookTime: json["cookTime"],
      complexity: json["complexity"],
      serves: json["serves"],
      imgUri: json["imgUri"],
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
