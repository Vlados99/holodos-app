import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/user/user_cubit.dart';
import 'package:holodos/presentation/pages/recipes_page.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/sized_box.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';
import 'package:holodos/presentation/widgets/text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: MainAppBar(
        title: "Reset password",
      ),
      resizeToAvoidBottomInset: true,
      key: _scaffoldGlobalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                return authState is Authenticated
                    ? RecipesPage()
                    : _bodyWidget();
              },
            );
          }
          return _bodyWidget();
        },
        listener: (context, userState) {
          if (userState is UserSuccess) {
            snackBarSuccess(
                context: context, message: "Success! Check your email");
          }

          if (userState is UserFailure) {
            snackBarError(context: context, message: "Invalid email");
          }
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          sb_h50(),
          const Text(
            "Reset your password",
            style: TextStyles.header,
          ),
          sb_h50(),
          SimpleTextField(
            controller: _emailController,
            labelText: "Enter your email",
            icon: const Icon(
              Icons.lock,
              color: AppColors.dirtyGreen,
            ),
          ),
          sb_h50(),
          GestureDetector(
            onTap: () => submitReset(),
            child: Button(
              context: context,
              backgroundColor: AppColors.button,
              fontColor: AppColors.textColorWhite,
              text: "Reset",
            ),
          ),
          sb_h15(),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, PageConst.signInPage, ((route) => false)),
            child: Button(
              context: context,
              text: "Go back",
              fontColor: AppColors.textColorDirtyGreen,
            ),
          ),
        ],
      ),
    );
  }

  submitReset() {
    if (_emailController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).resetPassword(
        user: UserEntity(
          email: _emailController.text,
        ),
      );
    }
  }
}
