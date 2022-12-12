import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/usecases/get_all_products.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetAllProducts getAllProductsUseCase;

  ProductCubit({required this.getAllProductsUseCase}) : super(ProductInitial());

  Future<void> getProducts() async {
    emit(ProductLoading());
    try {
      final failureOrProducts = await getAllProductsUseCase();
      failureOrProducts.fold((_) => emit(ProductFailure()),
          (value) => emit(ProductLoaded(products: value)));
    } on SocketException catch (_) {
      emit(ProductFailure());
    } catch (_) {
      emit(ProductFailure());
    }
  }
}
