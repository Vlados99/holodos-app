import 'dart:html';

import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String recipeCollectionID;
  final String content;
  final Blob? image;

  Comment(
      {required this.id,
      required this.recipeCollectionID,
      required this.content,
      this.image});

  @override
  List<Object?> get props => [id, recipeCollectionID, content, image];
}
