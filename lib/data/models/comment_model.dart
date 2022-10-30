import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({id, userName, content, image})
      : super(id: id, userName: userName, content: content, image: image);

  factory CommentModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CommentModel(
      id: snapshot.get('id'),
      userName: snapshot.get('userName'),
      content: snapshot.get('content'),
      image: snapshot.get('image'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'userName': userName,
      'content': content,
      'image': image,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      userName: json["userName"],
      content: json["content"],
      image: json["image"],
    );
  }
}
