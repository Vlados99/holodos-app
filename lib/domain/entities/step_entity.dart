import 'package:equatable/equatable.dart';

class StepEntity extends Equatable {
  final String id;
  final String? title;
  final int number;
  final String? imgUri;
  final String description;

  const StepEntity({
    required this.id,
    required this.number,
    this.title,
    this.imgUri,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, number, imgUri, description];
}
