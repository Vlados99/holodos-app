import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/user/user_cubit.dart';
import 'package:holodos/presentation/pages/recipes_page.dart';
import 'package:holodos/presentation/widgets/appbar/app_bar.dart';
import 'package:holodos/presentation/widgets/button.dart';
import 'package:holodos/presentation/widgets/sized_box.dart';
import 'package:holodos/presentation/widgets/snack_bar.dart';
import 'package:holodos/presentation/widgets/text_field.dart';

import '../widgets/drawer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldGLobalKey =
      GlobalKey<ScaffoldState>();

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
              return authState is Authenticated
                  ? const RecipesPage()
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
          snackBarError(message: userState.errorMessage, context: context);
        }
      },
    );
  }

  Widget _bodyWidget() {
    double buttonWidth = MediaQuery.of(context).size.width / 1.5;

    final h15 = CustomSizedBox().h15();
    final h50 = CustomSizedBox().h50();

    return Scaffold(
        drawer: SafeArea(
            child: AppDrawer(
          routeName: PageConst.signUpPage,
          width: MediaQuery.of(context).size.width - 80,
        )),
        resizeToAvoidBottomInset: true,
        appBar: const MainAppBar(),
        key: _scaffoldGLobalKey,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 80,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Column(
              children: [
                CustomSizedBox().h50(),
                const Text(
                  "Registration",
                  style: TextStyles.header,
                ),
                h50,
                SimpleTextField(
                  controller: _usernameController,
                  labelText: "Enter your username",
                ),
                h15,
                SimpleTextField(
                  controller: _emailController,
                  labelText: "Enter your email",
                ),
                h15,
                PasswordTextField(
                  context: context,
                  controller: _passwordController,
                  labelText: "Enter your password",
                ),
                h50,
                GestureDetector(
                  onTap: () => submitCreateAccount(),
                  child: Button(
                    width: MediaQuery.of(context).size.width - 240,
                    text: "Create account",
                    backgroundColor: AppColors.button,
                    fontColor: AppColors.textColorWhite,
                  ),
                ),
                h15,
                GestureDetector(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.recipesPage, ((route) => false)),
                  child: Button(
                    width: buttonWidth,
                    text: "Continue without registation",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyles.text16gray,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  PageConst.signInPage,
                                  ((route) => false)),
                              child: Row(
                                children: [
                                  Button(
                                    width:
                                        MediaQuery.of(context).size.width - 335,
                                    text: "Log in",
                                    fontColor: AppColors.textColorDirtyGreen,
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: AppColors.dirtyGreen,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                h15,
              ],
            ),
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
