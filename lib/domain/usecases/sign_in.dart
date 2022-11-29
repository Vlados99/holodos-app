import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class SignIn extends UseCaseWithParams<void, SignInParams> {
  final UserRepository repository;

  SignIn({required this.repository});

  @override
  Future<Either<Failure, void>> call(SignInParams params) async {
    return await repository.signIn(params.user);
  }
}

class SignInParams extends Equatable {
  final UserEntity user;

  const SignInParams({required this.user});

  @override
  List<Object?> get props => [user];
}
