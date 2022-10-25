import 'package:dartz/dartz.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

import '../../core/usecases/usecase.dart';

class SignOut extends UseCase<void> {
  final UserRepository repository;

  SignOut({required this.repository});

  @override
  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
