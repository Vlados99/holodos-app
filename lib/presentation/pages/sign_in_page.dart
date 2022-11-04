import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/user_entity.dart';
import 'package:holodos/presentation/cubit/auth/auth_cubit.dart';
import 'package:holodos/presentation/cubit/user/user_cubit.dart';
import 'package:holodos/presentation/pages/recipes_page.dart';
import 'package:holodos/presentation/widgets/snackbar.dart';
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
      appBar: _appBar(),
      key: _scaffoldGlobalKey,
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
            snackBarError(
                context: context, message: "Invalid email or password");
          }
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Sign in"),
    );
  }

  Widget _bodyWidget() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          CustomTextField().textField(
              controller: _emailController, hingText: "Enter your email"),
          CustomTextField().textField(
              controller: _passwordController, hingText: "Enter your password"),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () => submitSignIn(),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: const Text("Login"),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamedAndRemoveUntil(
                context, PageConst.signUpPage, ((route) => false)),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: const Text("Sign up"),
            ),
          ),
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
