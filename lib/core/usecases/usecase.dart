import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class UseCase<Type> {
  Future<Either<Failure, Type>> call();
}
