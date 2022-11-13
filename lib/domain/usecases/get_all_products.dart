import 'package:dartz/dartz.dart';

import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

import '../entities/product_entity.dart';

class GetAllProducts extends UseCase<void> {
  final UserRepository repository;
  GetAllProducts({required this.repository});

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getAllProducts();
  }
}
