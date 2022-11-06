import 'package:equatable/equatable.dart';

class TagEntity extends Equatable {
  final int id;
  final String name;

  TagEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
