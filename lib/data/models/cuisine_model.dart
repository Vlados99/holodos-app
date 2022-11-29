import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/cuisine_entity.dart';

class CuisineModel extends CuisineEntity {
  const CuisineModel({required id, required name}) : super(id: id, name: name);

  factory CuisineModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CuisineModel(
      id: snapshot.id,
      name: snapshot.data().toString().contains("name")
          ? snapshot.get("name")
          : '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
    };
  }
}
