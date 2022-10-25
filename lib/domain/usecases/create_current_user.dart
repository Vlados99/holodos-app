import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class CreateCurrentUser
    extends UseCaseWithParams<void, CreateCurrentUserParams> {
  final UserRepository repository;

  CreateCurrentUser({required this.repository});

  @override
  Future<Either<Failure, void>> call(CreateCurrentUserParams params) async {
    return await repository.createCurrentUser(params.user);
  }
}

class CreateCurrentUserParams extends Equatable {
  final UserEntity user;

  CreateCurrentUserParams({required this.user});

  @override
  List<Object?> get props => [user];
}
