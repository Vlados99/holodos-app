import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String? unit;
  final String? imageLocation;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.unit,
    this.imageLocation,
  });

  @override
  List<Object?> get props => [id, name, unit, imageLocation];
}
