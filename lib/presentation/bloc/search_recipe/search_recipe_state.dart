part of 'search_recipe_bloc.dart';

abstract class SearchRecipeState extends Equatable {
  const SearchRecipeState();

  @override
  List<Object?> get props => [];
}

class RecipeEmpty extends SearchRecipeState {}

class SearchRecipeLoading extends SearchRecipeState {}

class SearchRecipeLoaded extends SearchRecipeState {
  final List<RecipeEntity> recipes;

  SearchRecipeLoaded({required this.recipes});

  @override
  List<Object?> get props => [recipes];
}

class SearchRecipeError extends SearchRecipeState {
  final String message;

  SearchRecipeError({required this.message});

  @override
  List<Object?> get props => [message];
}
