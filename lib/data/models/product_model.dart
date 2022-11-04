import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({id, name, unit}) : super(id: id, name: name, unit: unit);

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ProductModel(
      id: snapshot.data().toString().contains('id') ? snapshot.get('id') : '',
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

  //?????????????????????????????????????????????????????????????????
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      unit: json["unit"],
    );
  }
}
