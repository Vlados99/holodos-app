import 'package:dartz/dartz.dart';
import 'package:holodos/core/error/failure.dart';
import 'package:holodos/core/usecases/usecase.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/repositories/user_repository.dart';

class GetAllCategories extends UseCase<void> {
  final UserRepository repository;
  GetAllCategories({required this.repository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await repository.getAllCategories();
  }
}
