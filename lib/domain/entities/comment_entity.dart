import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String userName;
  final String comment;

  const CommentEntity({
    required this.id,
    required this.userName,
    required this.comment,
  });

  @override
  List<Object?> get props => [id, userName, comment];
}
