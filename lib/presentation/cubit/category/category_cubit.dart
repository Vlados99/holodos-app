import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/domain/entities/category_entity.dart';
import 'package:holodos/domain/usecases/get_all_categories.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetAllCategories getAllCategoriesUseCase;

  CategoryCubit({required this.getAllCategoriesUseCase})
      : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      final failureOrCategories = await getAllCategoriesUseCase();
      failureOrCategories.fold((_) => emit(CategoryFailure()),
          (value) => emit(CategoryLoaded(categories: value)));
    } on SocketException catch (_) {
      emit(CategoryFailure());
    } catch (_) {
      emit(CategoryFailure());
    }
  }
}
