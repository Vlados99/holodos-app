import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams> {
  final UserRepository repository;

  SignUp({required this.repository});

  @override
  Future<Either<Failure, void>> call(SignUpParams params) async {
    return await repository.signUp(params.user);
  }
}

class SignUpParams extends Equatable {
  final UserEntity user;

  SignUpParams({required this.user});

  @override
  List<Object?> get props => [user];
}
