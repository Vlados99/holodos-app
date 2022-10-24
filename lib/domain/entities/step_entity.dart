import 'dart:html';

import 'package:equatable/equatable.dart';

class StepEntity extends Equatable {
  final String id;
  final String? title;
  final Blob image;
  final String content;

  const StepEntity(
      {required this.id,
      this.title,
      required this.image,
      required this.content});

  @override
  List<Object?> get props => [id, title, image, content];
}
