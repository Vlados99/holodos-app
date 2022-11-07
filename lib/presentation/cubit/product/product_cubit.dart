import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/usecases/add_product_to_user_list.dart';
import 'package:holodos/domain/usecases/get_all_products.dart';
import 'package:holodos/domain/usecases/get_list_of_users_products.dart';
import 'package:holodos/domain/usecases/remove_product_from_user_list.dart';
import 'package:holodos/domain/usecases/update_product_from_user_list.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final AddProductToUserList addProductToUserListUseCase;
  final GetListOfUsersProducts getListOfUsersProductsUseCase;
  final RemoveProductFromUserList removeProductFromUserListUseCase;
  final UpdateProductFromUserList updateProductFromUserListUseCase;

  final GetAllProducts getAllProductsUseCase;

  ProductCubit(
      {required this.addProductToUserListUseCase,
      required this.getListOfUsersProductsUseCase,
      required this.removeProductFromUserListUseCase,
      required this.updateProductFromUserListUseCase,
      required this.getAllProductsUseCase})
      : super(ProductInitial());

  Future<void> addProductToList(
      {required ProductEntity product, required String userId}) async {
    try {
      AddProductToUserListParams params =
          AddProductToUserListParams(uId: userId, product: product);
      await addProductToUserListUseCase(params);
    } on SocketException catch (_) {
      emit(ProductFailure());
    } catch (_) {
      emit(ProductFailure());
    }
  }

  Future<void> removeProductFromList(
      {required ProductEntity product, required String userId}) async {
    try {
      RemoveProductFromUserListParams params =
          RemoveProductFromUserListParams(uId: userId, product: product);
      await removeProductFromUserListUseCase(params);
    } on SocketException catch (_) {
      emit(ProductFailure());
    } catch (_) {
      emit(ProductFailure());
    }
  }

  Future<void> getProductsFromList({required String userId}) async {
    emit(ProductLoading());
    try {
      GetListOfUsersProductsParams params =
          GetListOfUsersProductsParams(uId: userId);
      final products = await getListOfUsersProductsUseCase(params);
      products.fold(
          (_) => emit(ProductFailure()),
          (value) => value.listen((products) {
                emit(ProductLoaded(products: products));
              }));
    } on SocketException catch (_) {
      emit(ProductFailure());
    } catch (_) {
      emit(ProductFailure());
    }
  }

  Future<void> getProducts() async {
    emit(ProductLoading());
    try {
      final products = await getAllProductsUseCase();
      products.fold(
          (_) => emit(ProductFailure()),
          (value) => value.listen((products) {
                emit(ProductLoaded(products: products));
              }));
    } on SocketException catch (_) {
      emit(ProductFailure());
    } catch (_) {
      emit(ProductFailure());
    }
  }
}
