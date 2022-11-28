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

class RecipesLoaded extends RecipeState {
  final List<RecipeEntity> recipes;

  RecipesLoaded({required this.recipes});

  @override
  List<Object> get props => [];
}

class RecipeLoaded extends RecipeState {
  final RecipeEntity recipe;

  RecipeLoaded({required this.recipe});

  @override
  List<Object> get props => [];
}
