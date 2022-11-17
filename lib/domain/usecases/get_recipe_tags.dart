import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/tag_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetRecipeTags
    extends UseCaseWithParams<List<TagEntity>, GetRecipeTagsParams> {
  final UserRepository repository;

  GetRecipeTags({required this.repository});

  @override
  Future<Either<Failure, List<TagEntity>>> call(params) async {
    return await repository.getRecipeTags(params.recipeId);
  }
}

class GetRecipeTagsParams extends Equatable {
  String recipeId;

  GetRecipeTagsParams({required this.recipeId});

  @override
  List<Object?> get props => [recipeId];
}
