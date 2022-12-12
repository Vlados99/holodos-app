part of 'user_product_cubit.dart';

abstract class UserProductState extends Equatable {
  const UserProductState();
}

class UserProductInitial extends UserProductState {
  @override
  List<Object> get props => [];
}

class UserProductLoading extends UserProductState {
  @override
  List<Object?> get props => [];
}

class UserProductFailure extends UserProductState {
  @override
  List<Object> get props => [];
}

class UserProductLoaded extends UserProductState {
  final List<ProductEntity> products;

  const UserProductLoaded({required this.products});

  @override
  List<Object> get props => [products];
}
