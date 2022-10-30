import 'dart:html';

import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String userName;
  final String content;
  final Blob? image;

  const CommentEntity({
    required this.id,
    required this.userName,
    required this.content,
    this.image,
  });

  @override
  List<Object?> get props => [id, userName, content, image];
}
