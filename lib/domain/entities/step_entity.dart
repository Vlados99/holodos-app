import 'package:equatable/equatable.dart';

class StepEntity extends Equatable {
  final String id;
  final String? title;
  final int number;
  final String? imageLocation;
  final String description;

  const StepEntity({
    required this.id,
    required this.number,
    this.title,
    this.imageLocation,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, number, imageLocation, description];
}
