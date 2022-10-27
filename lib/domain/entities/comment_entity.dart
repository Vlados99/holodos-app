import 'dart:html';

import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String content;
  final Blob? image;

  const CommentEntity({
    required this.id,
    required this.content,
    this.image,
  });

  @override
  List<Object?> get props => [id, content, image];
}
