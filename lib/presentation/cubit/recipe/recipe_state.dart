part of 'recipe_cubit.dart';

abstract class RecipesState extends Equatable {
  const RecipesState();
}

abstract class RecipeState extends Equatable {
  const RecipeState();
}

class RecipesInitial extends RecipesState {
  @override
  List<Object> get props => [];
}

class RecipesLoading extends RecipesState {
  @override
  List<Object> get props => [];
}

class RecipesFailure extends RecipesState {
  @override
  List<Object> get props => [];
}

class RecipesLoaded extends RecipesState {
  final List<RecipeEntity> recipes;

  const RecipesLoaded({required this.recipes});

  @override
  List<Object> get props => [];
}

class RecipeLoaded extends RecipeState {
  final RecipeEntity recipe;

  const RecipeLoaded({required this.recipe});

  @override
  List<Object> get props => [];
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
