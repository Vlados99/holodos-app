import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/tag_entity.dart';

class TagModel extends TagEntity {
  TagModel({id, name}) : super(id: id, name: name);

  factory TagModel.fromSnapshot(DocumentSnapshot snapshot) {
    return TagModel(
      id: snapshot.data().toString().contains("id") ? snapshot.get("id") : '',
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

  //?????????????????????????????????????????????????????????????????
  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json["id"],
      name: json["name"],
    );
  }
}
