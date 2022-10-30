import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetListOfUsersProducts extends UseCaseWithParams<
    Stream<List<ProductEntity>>, GetListOfUsersProductsParams> {
  final UserRepository repository;

  GetListOfUsersProducts({required this.repository});

  @override
  Future<Either<Failure, Stream<List<ProductEntity>>>> call(
      GetListOfUsersProductsParams params) async {
    return await repository.getListOfUsersProducts(params.uId);
  }
}

class GetListOfUsersProductsParams extends Equatable {
  final String uId;

  GetListOfUsersProductsParams({required this.uId});

  @override
  List<Object?> get props => [uId];
}
