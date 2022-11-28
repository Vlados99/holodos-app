part of 'cuisine_cubit.dart';

abstract class CuisineState extends Equatable {
  const CuisineState();
}

class CuisineInitial extends CuisineState {
  @override
  List<Object> get props => [];
}

class CuisineLoading extends CuisineState {
  @override
  List<Object?> get props => [];
}

class CuisineFailure extends CuisineState {
  @override
  List<Object> get props => [];
}

class CuisineLoaded extends CuisineState {
  final List<CuisineEntity> cuisines;

  CuisineLoaded({required this.cuisines});

  @override
  List<Object> get props => [cuisines];
}
