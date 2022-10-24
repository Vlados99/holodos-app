import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;

  Product({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
