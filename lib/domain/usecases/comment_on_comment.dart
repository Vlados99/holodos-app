import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class CommentOnComment extends UseCaseWithParams<void, CommentOnCommentParams> {
  final UserRepository repository;

  CommentOnComment({required this.repository});

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.commentOnComment(
        params.uId, params.response, params.comment);
  }
}

class CommentOnCommentParams extends Equatable {
  final String uId;
  final CommentEntity response;
  final CommentEntity comment;

  CommentOnCommentParams(
      {required this.uId, required this.response, required this.comment});

  @override
  List<Object?> get props => [uId, response, comment];
}
