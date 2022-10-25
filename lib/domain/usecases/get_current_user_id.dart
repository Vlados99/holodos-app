import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetCurrentUserId extends UseCase<String> {
  final UserRepository repository;

  GetCurrentUserId({required this.repository});

  @override
  Future<Either<Failure, String>> call() async {
    return await repository.getCurrentUId();
  }
}
