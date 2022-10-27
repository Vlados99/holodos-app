import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({id, content, image})
      : super(id: id, content: content, image: image);

  factory CommentModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CommentModel(
      id: snapshot.get('id'),
      content: snapshot.get('content'),
      image: snapshot.get('image'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'content': content,
      'image': image,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      content: json["content"],
      image: json["image"],
    );
  }
}
