import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StepEntity extends Equatable {
  final String id;
  final String? title;
  final String? image;
  final String content;

  const StepEntity({
    required this.id,
    this.title,
    this.image,
    required this.content,
  });

  @override
  List<Object?> get props => [id, title, image, content];
}
