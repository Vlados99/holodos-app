import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String? unit;

  const ProductEntity({required this.id, required this.name, this.unit});

  @override
  List<Object?> get props => [id, name, unit];
}
