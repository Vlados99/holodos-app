import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/step_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetRecipeSteps
    extends UseCaseWithParams<List<StepEntity>, GetRecipeStepsParams> {
  final UserRepository repository;

  GetRecipeSteps({required this.repository});

  @override
  Future<Either<Failure, List<StepEntity>>> call(params) async {
    return await repository.getRecipeSteps(params.recipeId);
  }
}

class GetRecipeStepsParams extends Equatable {
  String recipeId;

  GetRecipeStepsParams({required this.recipeId});

  @override
  List<Object?> get props => [recipeId];
}
