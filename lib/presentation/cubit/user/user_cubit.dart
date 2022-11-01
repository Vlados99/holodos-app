import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/domain/usecases/create_current_user.dart';
import 'package:holodos/domain/usecases/sign_in.dart';
import 'package:holodos/domain/usecases/sign_up.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignIn signIn;
  final SignUp signUp;
  final CreateCurrentUser createCurrentUser;

  UserCubit(
      {required this.signIn,
      required this.signUp,
      required this.createCurrentUser})
      : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try {
      SignInParams params = SignInParams(user: user);
      await signIn(params);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      SignUpParams signUpParams = SignUpParams(user: user);
      CreateCurrentUserParams createCurrentUserParams =
          CreateCurrentUserParams(user: user);

      await signUp(signUpParams);
      await createCurrentUser(createCurrentUserParams);

      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
