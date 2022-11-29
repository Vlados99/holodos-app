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

  const SearchRecipeLoaded({required this.recipes});

  @override
  List<Object?> get props => [recipes];
}

class SearchRecipeFailure extends SearchRecipeState {
  final String message;

  const SearchRecipeFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
