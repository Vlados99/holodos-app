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

import '../widgets/drawer.dart';

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
  void initState() {
    _emailController.clear();
    _usernameController.clear();
    _passwordController.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _consumer();
  }

  Widget _consumer() {
    return BlocConsumer<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserSuccess) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              return authState is Authenticated ? RecipesPage() : _bodyWidget();
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
          snackBarError(message: userState.errorMessage, context: context);
        }
      },
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
        drawer: SafeArea(
            child: AppDrawer(
                routeName: PageConst.recipesPage,
                width: MediaQuery.of(context).size.width - 80,
                context: context)),
        resizeToAvoidBottomInset: false,
        appBar: MainAppBar(title: "Sign up"),
        key: _scaffoldGLobalKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
            children: [
              sb_h50(),
              const Text(
                "Registration",
                style: TextStyles.header,
              ),
              sb_h50(),
              SimpleTextField(
                context: context,
                controller: _usernameController,
                labelText: "Enter your username",
                icon: Icon(
                  Icons.person,
                  color: AppColors.dirtyGreen,
                ),
              ),
              sb_h15(),
              SimpleTextField(
                context: context,
                controller: _emailController,
                labelText: "Enter your email",
                icon: Icon(
                  Icons.email,
                  color: AppColors.dirtyGreen,
                ),
              ),
              sb_h15(),
              PasswordTextField(
                context: context,
                controller: _passwordController,
                labelText: "Enter your password",
                icon: Icon(
                  Icons.lock,
                  color: AppColors.dirtyGreen,
                ),
              ),
              sb_h50(),
              GestureDetector(
                onTap: () => submitCreateAccount(),
                child: Button(
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
                child: Button(
                  context: context,
                  text: "Sign in",
                  fontColor: AppColors.textColorDirtyGreen,
                ),
              ),
              sb_h15(),
              GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context, PageConst.recipesPage, ((route) => false)),
                child: Button(
                  context: context,
                  text: "Continue without registation",
                  fontColor: AppColors.textColorDirtyGreen,
                ),
              ),
            ],
          ),
        ));
  }

  submitCreateAccount() {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(
        user: UserEntity(
          name: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    } else {
      snackBarError(context: context, message: "Enter data in the fields");
    }
  }
}
