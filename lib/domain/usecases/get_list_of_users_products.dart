import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetListOfUsersProducts extends UseCase<List<ProductEntity>> {
  final UserRepository repository;

  GetListOfUsersProducts({required this.repository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getListOfUsersProducts();
  }
}
