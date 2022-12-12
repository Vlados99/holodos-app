import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/common/network_status_service.dart';
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

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<ScaffoldState> _scaffoldGlobalKey =
      GlobalKey<ScaffoldState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    checkConnection(context);

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
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
          snackBarError(context: context, message: userState.errorMessage);
        }
      },
    );
  }

  Widget _bodyWidget() {
    double buttonWidth = MediaQuery.of(context).size.width / 1.5;

    final h15 = CustomSizedBox().h15();
    final h50 = CustomSizedBox().h50();
    final h1 = CustomSizedBox().h1();

    return Scaffold(
        drawer: SafeArea(
            child: AppDrawer(
          routeName: PageConst.signInPage,
          width: MediaQuery.of(context).size.width - 80,
        )),
        resizeToAvoidBottomInset: true,
        appBar: const MainAppBar(),
        key: _scaffoldGlobalKey,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 80,
            alignment: Alignment.center,
            child: Column(
              children: [
                h50,
                const Text(
                  "Welcome to Holodos",
                  style: TextStyles.header,
                ),
                h50,
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
                h1,
                GestureDetector(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.resetPasswordPage, ((route) => false)),
                  child: Button(
                    width: MediaQuery.of(context).size.width - 50,
                    text: "Forgot password?",
                    fontColor: AppColors.textColorDirtyGreen,
                    alignment: Alignment.centerRight,
                  ),
                ),
                h50,
                GestureDetector(
                  onTap: () => submitSignIn(),
                  child: Button(
                    width: MediaQuery.of(context).size.width / 4,
                    backgroundColor: AppColors.button,
                    fontColor: AppColors.textColorWhite,
                    text: "Log in",
                  ),
                ),
                h15,
                GestureDetector(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, PageConst.recipesPage, ((route) => false)),
                  child: Button(
                    width: buttonWidth,
                    text: "Continue without login",
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
                              "New Holodos?",
                              style: TextStyles.text16gray,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  PageConst.signUpPage,
                                  ((route) => false)),
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Button(
                                      text: "Create Account",
                                      fontColor: AppColors.textColorDirtyGreen,
                                    ),
                                  ),
                                  Icon(
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

  submitSignIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(
        user: UserEntity(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    } else {
      snackBarError(context: context, message: "Enter data in the fields");
    }
  }
}
