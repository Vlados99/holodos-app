import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetUserListWithProducts extends UseCaseWithParams<
    Stream<List<ProductEntity>>, GetUserListWithProductsParams> {
  final UserRepository repository;

  GetUserListWithProducts({required this.repository});

  @override
  Future<Either<Failure, Stream<List<ProductEntity>>>> call(
      GetUserListWithProductsParams params) async {
    return await repository.getUserListWithProducts(params.uId);
  }
}

class GetUserListWithProductsParams extends Equatable {
  final String uId;

  GetUserListWithProductsParams({required this.uId});

  @override
  List<Object?> get props => [uId];
}
