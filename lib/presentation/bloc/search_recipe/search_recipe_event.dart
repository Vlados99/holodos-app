part of 'search_recipe_bloc.dart';

abstract class SearchRecipeEvent extends Equatable {
  const SearchRecipeEvent();

  @override
  List<Object> get props => [];
}

class LoadRecipes extends SearchRecipeEvent {}

class SearchRecipesByNameBloc extends SearchRecipeEvent {
  final String name;

  const SearchRecipesByNameBloc(this.name);
}
