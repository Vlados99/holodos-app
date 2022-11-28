import 'package:equatable/equatable.dart';

class CuisineEntity extends Equatable {
  final String id;
  final String name;

  CuisineEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
