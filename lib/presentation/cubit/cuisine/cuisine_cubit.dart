import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/domain/entities/cuisine_entity.dart';
import 'package:holodos/domain/usecases/get_all_cuisines.dart';

part 'cuisine_state.dart';

class CuisineCubit extends Cubit<CuisineState> {
  final GetAllCuisines getAllCuisinesUseCase;

  CuisineCubit({required this.getAllCuisinesUseCase}) : super(CuisineInitial());

  Future<void> getCuisines() async {
    emit(CuisineLoading());
    try {
      final cuisines = await getAllCuisinesUseCase();
      cuisines.fold((_) => emit(CuisineFailure()),
          (value) => emit(CuisineLoaded(cuisines: value)));
    } on SocketException catch (_) {
      emit(CuisineFailure());
    } catch (_) {
      emit(CuisineFailure());
    }
  }
}
