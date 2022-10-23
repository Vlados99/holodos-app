import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final int id;
  final String name;

  Ingredient({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
