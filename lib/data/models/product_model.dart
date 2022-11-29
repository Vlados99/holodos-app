import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({required id, required name, required unit})
      : super(id: id, name: name, unit: unit);

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ProductModel(
      id: snapshot.id,
      name: snapshot.data().toString().contains('name')
          ? snapshot.get('name')
          : '',
      unit: snapshot.data().toString().contains('unit')
          ? snapshot.get('unit')
          : '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
    };
  }
}
