import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/user/user_cubit.dart';
import 'package:holodos/presentation/pages/recipes_page.dart';
import 'package:holodos/presentation/widgets/snackbar.dart';
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
      key: _scaffoldGLobalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                return authState is Authenticated
                    ? RecipesPage(uId: authState.userId)
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
            snackBarError(message: "Invalid email", context: context);
          }
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, PageConst.signInPage, (route) => false),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: const Text("Go back to login"),
            ),
          ),
          CustomTextField().textField(
              controller: _usernameController, hingText: "Enter your username"),
          CustomTextField().textField(
              controller: _emailController, hingText: "Enter your email"),
          CustomTextField().textField(
              controller: _passwordController, hingText: "Enter your password"),
          GestureDetector(
            onTap: () => submitSignIn(),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: const Text("Create my account"),
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
