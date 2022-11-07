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

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldGLobalKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _usernameController.dispose();
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
      appBar: simpleAppBar(title: "Sign up"),
      key: _scaffoldGLobalKey,
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
            snackBarError(message: "Invalid data", context: context);
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
            "Registration",
            style: TextStyles.header,
          ),
          sb_h50(),
          textField(
              context: context,
              controller: _usernameController,
              hingText: "Enter your username"),
          sb_h15(),
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
              text: "Create account",
              backgroundColor: AppColors.button,
              fontColor: AppColors.textColorWhite,
            ),
          ),
          sb_h15(),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, PageConst.signInPage, ((route) => false)),
            child: button(
              context: context,
              text: "Sign in",
              fontColor: AppColors.textColorDirtyGreen,
            ),
          ),
        ],
      ),
    );
  }

  submitSignIn() {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(
        user: UserEntity(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
