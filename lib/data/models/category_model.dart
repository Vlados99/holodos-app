import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required id, required name}) : super(id: id, name: name);

  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CategoryModel(
      id: snapshot.id,
      name: snapshot.data().toString().contains("name")
          ? snapshot.get('name')
          : '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
    );
  }
}
