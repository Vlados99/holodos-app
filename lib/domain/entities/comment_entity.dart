import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String userName;
  final String comment;
  final Timestamp date;

  const CommentEntity(
      {required this.id,
      required this.userName,
      required this.comment,
      required this.date});

  @override
  List<Object?> get props => [id, userName, comment, date];
}
