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

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: simpleAppBar(title: "Sign in"),
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
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }

          if (userState is UserFailure) {
            snackBarError(
                context: context, message: "Invalid email or password");
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
            "Welcome to Holodos",
            style: TextStyles.header,
          ),
          sb_h50(),
          textField(
              context: context,
              controller: _emailController,
              hingText: "Enter your email"),
          sb_h15(),
          textField(
              context: context,
              controller: _passwordController,
              hingText: "Enter your password"),
          sb_h50(),
          GestureDetector(
            onTap: () => submitSignIn(),
            child: button(
              context: context,
              backgroundColor: AppColors.button,
              fontColor: AppColors.textColorWhite,
              text: "Login",
            ),
          ),
          sb_h15(),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, PageConst.resetPasswordPage, ((route) => false)),
            child: button(
              context: context,
              text: "Forgot password?",
              fontColor: AppColors.textColorDirtyGreen,
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 0.0,
                children: [
                  const Text(
                    "New Holodos?",
                    style: TextStyles.text16black,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context, PageConst.signUpPage, ((route) => false)),
                    child: button(
                      width: 75,
                      context: context,
                      text: "Sign up",
                      fontColor: AppColors.textColorDirtyGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
          sb_h15(),
        ],
      ),
    );
  }

  submitSignIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(
        user: UserEntity(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
