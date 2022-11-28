import 'package:dartz/dartz.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase.dart';
import 'package:holodos/domain/entities/cuisine_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetAllCuisines extends UseCase<void> {
  final UserRepository repository;
  GetAllCuisines({required this.repository});

  @override
  Future<Either<Failure, List<CuisineEntity>>> call() async {
    return await repository.getAllCuisines();
  }
}
