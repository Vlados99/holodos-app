import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/domain/usecases/get_current_user_id.dart';
import 'package:holodos/domain/usecases/is_sign_in.dart';
import 'package:holodos/domain/usecases/sign_out.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUserId getCurrentUserId;
  final IsSignIn isSignIn;
  final SignOut signOut;

  AuthCubit(
      {required this.isSignIn,
      required this.signOut,
      required this.getCurrentUserId})
      : super(AuthInitial());

  Future<void> userIsSignIn() async {
    final _isSignIn = await isSignIn();

    _isSignIn.fold((failure) => emit(UnAuthenticated()), (value) async {
      if (value) {
        final userId = await getCurrentUserId();
        emit(Authenticated(userId: userId.getOrElse(() => '')));
      } else {
        emit(UnAuthenticated());
      }
    });
  }

  Future<void> loggedIn() async {
    try {
      final userId = await getCurrentUserId();
      emit(Authenticated(userId: userId.getOrElse(() => '')));
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOut();
      emit(UnAuthenticated());
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }
}
