import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class UpdateProductFromUserList
    extends UseCaseWithParams<void, UpdateProductFromUserListParams> {
  final UserRepository repository;

  UpdateProductFromUserList({required this.repository});

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.updateProductFromUserList(params.product);
  }
}

class UpdateProductFromUserListParams extends Equatable {
  final ProductEntity product;

  const UpdateProductFromUserListParams({required this.product});

  @override
  List<Object?> get props => [product];
}
