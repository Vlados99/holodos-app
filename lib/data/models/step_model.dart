import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/step_entity.dart';

class StepModel extends StepEntity {
  const StepModel(
      {required id,
      required title,
      required number,
      required imageLocation,
      required description})
      : super(
            id: id,
            title: title,
            imageLocation: imageLocation,
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
      imageLocation: snapshot.data().toString().contains("imageLocation")
          ? (snapshot.get("imageLocation")
                  as DocumentReference<Map<String, dynamic>>)
              .id
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
      'imageLocation': imageLocation,
      'description': description,
    };
  }
}
