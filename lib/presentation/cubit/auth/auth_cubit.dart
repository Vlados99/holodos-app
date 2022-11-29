import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/domain/usecases/get_current_user_id.dart';
import 'package:holodos/domain/usecases/is_sign_in.dart';
import 'package:holodos/domain/usecases/sign_out.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUserId getCurrentUserIdUseCase;
  final IsSignIn isSignInUseCase;
  final SignOut signOutUseCase;

  AuthCubit(
      {required this.isSignInUseCase,
      required this.signOutUseCase,
      required this.getCurrentUserIdUseCase})
      : super(AuthInitial());

  Future<void> userIsSignIn() async {
    final isSignIn = await isSignInUseCase();

    isSignIn.fold((failure) => emit(UnAuthenticated()), (value) async {
      if (value) {
        final userId = await getCurrentUserIdUseCase();
        emit(Authenticated(userId: userId.getOrElse(() => '')));
      } else {
        emit(UnAuthenticated());
      }
    });
  }

  Future<void> loggedIn() async {
    try {
      final userId = await getCurrentUserIdUseCase();
      emit(Authenticated(userId: userId.getOrElse(() => '')));
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase();
      emit(UnAuthenticated());
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }
}
