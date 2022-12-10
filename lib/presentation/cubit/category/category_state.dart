part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryFailure extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;

  const CategoryLoaded({required this.categories});

  @override
  List<Object> get props => [categories];
}
