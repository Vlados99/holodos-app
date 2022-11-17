import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/comment_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetRecipeComments
    extends UseCaseWithParams<List<CommentEntity>, GetRecipeCommentsParams> {
  final UserRepository repository;

  GetRecipeComments({required this.repository});

  @override
  Future<Either<Failure, List<CommentEntity>>> call(params) async {
    return await repository.getRecipeComments(params.recipeId);
  }
}

class GetRecipeCommentsParams extends Equatable {
  String recipeId;

  GetRecipeCommentsParams({required this.recipeId});

  @override
  List<Object?> get props => [recipeId];
}
