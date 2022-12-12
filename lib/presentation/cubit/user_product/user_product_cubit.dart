import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/product_entity.dart';
import 'package:holodos/domain/usecases/add_product_to_user_list.dart';
import 'package:holodos/domain/usecases/get_list_of_users_products.dart';
import 'package:holodos/domain/usecases/remove_product_from_user_list.dart';
import 'package:holodos/domain/usecases/update_product_from_user_list.dart';

part 'user_product_state.dart';

class UserProductCubit extends Cubit<UserProductState> {
  final AddProductToUserList addProductToUserListUseCase;
  final GetListOfUsersProducts getListOfUsersProductsUseCase;
  final RemoveProductFromUserList removeProductFromUserListUseCase;
  final UpdateProductFromUserList updateProductFromUserListUseCase;

  UserProductCubit({
    required this.addProductToUserListUseCase,
    required this.getListOfUsersProductsUseCase,
    required this.removeProductFromUserListUseCase,
    required this.updateProductFromUserListUseCase,
  }) : super(UserProductInitial());

  Future<void> addProductToList({required ProductEntity product}) async {
    try {
      AddProductToUserListParams params =
          AddProductToUserListParams(product: product);
      await addProductToUserListUseCase(params);
    } on SocketException catch (_) {
      emit(UserProductFailure());
    } catch (_) {
      emit(UserProductFailure());
    }
  }

  Future<void> removeProductFromList({required ProductEntity product}) async {
    emit(UserProductLoading());
    try {
      RemoveProductFromUserListParams params =
          RemoveProductFromUserListParams(product: product);
      await removeProductFromUserListUseCase(params);

      final failureOrProducts = await getListOfUsersProductsUseCase();
      failureOrProducts.fold((_) => emit(UserProductFailure()),
          (value) => emit(UserProductLoaded(products: value)));
    } on SocketException catch (_) {
      emit(UserProductFailure());
    } catch (_) {
      emit(UserProductFailure());
    }
  }

  Future<void> getProductsFromList() async {
    emit(UserProductLoading());
    try {
      final failureOrProducts = await getListOfUsersProductsUseCase();
      failureOrProducts.fold((_) => emit(UserProductFailure()),
          (value) => emit(UserProductLoaded(products: value)));
    } on SocketException catch (e) {
      print(e);
      emit(UserProductFailure());
    } catch (e) {
      print(e);
      emit(UserProductFailure());
    }
  }

  Future<void> updateProductFromUserList(
      {required ProductEntity product}) async {
    emit(UserProductLoading());
    try {
      UpdateProductFromUserListParams params =
          UpdateProductFromUserListParams(product: product);
      await updateProductFromUserListUseCase(params);

      final failureOrProducts = await getListOfUsersProductsUseCase();
      failureOrProducts.fold((_) => emit(UserProductFailure()),
          (value) => emit(UserProductLoaded(products: value)));
    } on SocketException catch (_) {
      emit(UserProductFailure());
    } catch (_) {
      emit(UserProductFailure());
    }
  }
}
