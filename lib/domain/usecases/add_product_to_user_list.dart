import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class AddProductToUserList
    extends UseCaseWithParams<void, AddProductToUserListParams> {
  final UserRepository repository;

  AddProductToUserList({required this.repository});

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.addProductToUserList(params.product);
  }
}

class AddProductToUserListParams extends Equatable {
  final ProductEntity product;

  const AddProductToUserListParams({required this.product});

  @override
  List<Object?> get props => [product];
}
