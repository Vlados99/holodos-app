import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({id, userName, comment})
      : super(id: id, userName: userName, comment: comment);

  factory CommentModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CommentModel(
      id: snapshot.data().toString().contains("id") ? snapshot.get('id') : '',
      userName: snapshot.data().toString().contains("userName")
          ? snapshot.get('userName')
          : '',
      comment: snapshot.data().toString().contains("comment")
          ? snapshot.get('comment')
          : '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'userName': userName,
      'comment': comment,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      userName: json["userName"],
      comment: json["comment"],
    );
  }
}
