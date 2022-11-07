import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/step_entity.dart';

class StepModel extends StepEntity {
  StepModel(
      {required id,
      required title,
      required number,
      required imgUri,
      required description})
      : super(
            id: id,
            title: title,
            imgUri: imgUri,
            number: number,
            description: description);

  factory StepModel.fromSnapshot(DocumentSnapshot snapshot) {
    return StepModel(
      id: snapshot.id,
      title: snapshot.data().toString().contains("title")
          ? snapshot.get("title")
          : '',
      number: snapshot.data().toString().contains("number")
          ? snapshot.get("number")
          : 0,
      imgUri: snapshot.data().toString().contains("imgUri")
          ? snapshot.get("imgUri").toString()
          : '',
      description: snapshot.data().toString().contains("description")
          ? snapshot.get("description")
          : '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'number': number,
      'imgUri': imgUri,
      'description': description,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      id: json["id"],
      title: json["title"],
      number: json["number"],
      imgUri: json["imgUri"],
      description: json["description"],
    );
  }
}
