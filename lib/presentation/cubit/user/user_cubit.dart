// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/domain/usecases/create_current_user.dart';
import 'package:holodos/domain/usecases/reset_password.dart';
import 'package:holodos/domain/usecases/sign_in.dart';
import 'package:holodos/domain/usecases/sign_up.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignIn signInUseCase;
  final SignUp signUpUseCase;
  final CreateCurrentUser createCurrentUserUseCase;
  final ResetPassword resetPasswordUseCase;

  UserCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.createCurrentUserUseCase,
    required this.resetPasswordUseCase,
  }) : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try {
      SignInParams params = SignInParams(user: user);
      await signInUseCase(params);
      emit(UserSuccess());
    } on FirebaseException catch (e) {
      emit(UserFailure(errorMessage: e.message!));
    } catch (_) {
      emit(const UserFailure(errorMessage: "Unknown error"));
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      SignUpParams signUpParams = SignUpParams(user: user);
      CreateCurrentUserParams createCurrentUserParams =
          CreateCurrentUserParams(user: user);

      await signUpUseCase(signUpParams);
      await createCurrentUserUseCase(createCurrentUserParams);

      emit(UserSuccess());
    } on FirebaseException catch (e) {
      emit(UserFailure(errorMessage: e.message!));
    } catch (_) {
      emit(const UserFailure(errorMessage: "Unknown error"));
    }
  }

  Future<void> resetPassword({required UserEntity user}) async {
    emit(UserLoading());
    try {
      ResetPasswordParams params = ResetPasswordParams(user: user);

      final failureOrVoid = await resetPasswordUseCase(params);
      failureOrVoid.fold((_) => emit(const UserFailure(errorMessage: "Error")),
          (l) => emit(UserSuccess()));
    } on FirebaseException catch (e) {
      emit(UserFailure(errorMessage: e.message!));
    } catch (_) {
      emit(const UserFailure(errorMessage: "Unknown error"));
    }
  }
}
