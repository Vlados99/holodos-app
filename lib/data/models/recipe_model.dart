import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/data/models/category_model.dart';
import 'package:holodos/data/models/comment_model.dart';
import 'package:holodos/data/models/product_model.dart';
import 'package:holodos/data/models/step_model.dart';
import 'package:holodos/domain/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity {
  RecipeModel({
    required id,
    required name,
    required cookTime,
    required howEasy,
    required serves,
    required imageUri,
    required categories,
    required ingredients, // = products
    required steps,
    comments,
  }) : super(
          id: id,
          name: name,
          cookTime: cookTime,
          howEasy: howEasy,
          serves: serves,
          imageUri: imageUri,
          categories: categories,
          ingredients: ingredients,
          steps: steps,
          comments: comments,
        );
/*
  factory RecipeModel.fromSnapshot(DocumentSnapshot snapshot) {
    return RecipeModel(
      id: snapshot.get('id'),
      name: snapshot.get('name'),
      cookTime: snapshot.get('cookTime'),
      howEasy: snapshot.get('howEasy'),
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
    required List<ProductModel> ingredients,
    required List<StepModel> steps,
    required List<CategoryModel> categories,
    List<CommentModel>? comments,
  }) {
    return RecipeModel(
      id: snapshot.data().toString().contains('id') ? snapshot.get('id') : '',
      name: snapshot.data().toString().contains('name')
          ? snapshot.get('name')
          : '',
      cookTime: snapshot.data().toString().contains('cookTime')
          ? snapshot.get('cookTime')
          : '',
      howEasy: snapshot.data().toString().contains('howEasy')
          ? snapshot.get('howEasy')
          : '',
      serves: snapshot.data().toString().contains('serves')
          ? snapshot.get('serves')
          : '',
      imageUri: snapshot.data().toString().contains('serimageUrives')
          ? snapshot.get('imageUri')
          : '',
      categories: categories,
      ingredients: ingredients,
      steps: steps,
      comments: comments ?? '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'cookTime': cookTime,
      'howEasy': howEasy,
      'serves': serves,
      'imageUri': imageUri,
      'categories': categories,
      'ingredients': ingredients,
      'steps': steps,
      'comments': comments,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json["_id"],
      name: json["name"],
      cookTime: json["cookTime"],
      howEasy: json["howEasy"],
      serves: json["serves"],
      imageUri: json["imageUri"],
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
    );
  }
}
