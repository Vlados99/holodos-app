part of 'recipe_cubit.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();
}

class RecipeInitial extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeLoading extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeFailure extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeLoaded extends RecipeState {
  final List<RecipeEntity> recipes;

  RecipeLoaded({required this.recipes});

  @override
  List<Object> get props => [];
}
