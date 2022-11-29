import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class RemoveProductFromUserList
    extends UseCaseWithParams<void, RemoveProductFromUserListParams> {
  final UserRepository repository;

  RemoveProductFromUserList({required this.repository});

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.removeProductFromUserList(params.product);
  }
}

class RemoveProductFromUserListParams extends Equatable {
  final ProductEntity product;

  const RemoveProductFromUserListParams({required this.product});

  @override
  List<Object?> get props => [product];
}
