import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/step_entity.dart';

class StepModel extends StepEntity {
  StepModel({id, title, image, content})
      : super(id: id, title: title, image: image, content: content);

  factory StepModel.fromSnapshot(DocumentSnapshot snapshot) {
    return StepModel(
      id: snapshot.data().toString().contains("id") ? snapshot.get('id') : '',
      title: snapshot.data().toString().contains("title")
          ? snapshot.get('title')
          : '',
      image: snapshot.data().toString().contains("image")
          ? snapshot.get('image')
          : '',
      content: snapshot.data().toString().contains("content")
          ? snapshot.get('content')
          : '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'content': content,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      content: json["content"],
    );
  }
}
