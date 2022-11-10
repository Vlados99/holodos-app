import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holodos/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel(
      {required id, required userName, required comment, required date})
      : super(id: id, userName: userName, comment: comment, date: date);

  factory CommentModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CommentModel(
      id: snapshot.id,
      userName: snapshot.data().toString().contains("userName")
          ? snapshot.get('userName')
          : '',
      comment: snapshot.data().toString().contains("comment")
          ? snapshot.get('comment')
          : '',
      date: snapshot.data().toString().contains("date")
          ? snapshot.get('date')
          : '',
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'userName': userName,
      'comment': comment,
      'date': date,
    };
  }

  //?????????????????????????????????????????????????????????????????
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json["id"],
      userName: json["userName"],
      comment: json["comment"],
      date: json["date"],
    );
  }
}
