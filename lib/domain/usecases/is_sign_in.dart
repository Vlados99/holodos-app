import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class IsSignIn extends UseCase<bool> {
  final UserRepository repository;

  IsSignIn({required this.repository});

  @override
  Future<Either<Failure, bool>> call() async {
    return await repository.isSignIn();
  }
}
