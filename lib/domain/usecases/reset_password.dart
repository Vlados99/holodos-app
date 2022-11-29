import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class ResetPassword extends UseCaseWithParams<void, ResetPasswordParams> {
  final UserRepository repository;

  ResetPassword({required this.repository});

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.resetPassword(params.user);
  }
}

class ResetPasswordParams extends Equatable {
  final UserEntity user;

  const ResetPasswordParams({required this.user});

  @override
  List<Object?> get props => [user];
}
