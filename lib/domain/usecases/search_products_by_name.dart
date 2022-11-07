import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase_with_params.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class SearchProductsByName extends UseCaseWithParams<
    Stream<List<ProductEntity>>, SearchProductsByNameParams> {
  final UserRepository repository;

  SearchProductsByName({required this.repository});

  @override
  Future<Either<Failure, Stream<List<ProductEntity>>>> call(params) async {
    return await repository.searchProductsByName(params.name);
  }
}

class SearchProductsByNameParams extends Equatable {
  final String name;

  SearchProductsByNameParams({required this.name});

  @override
  List<Object?> get props => [name];
}
