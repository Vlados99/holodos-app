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

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldGlobalKey =
      GlobalKey<ScaffoldState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    checkConnection(context);

    super.initState();
  }

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
      appBar: const MainAppBar(),
      resizeToAvoidBottomInset: true,
      key: _scaffoldGlobalKey,
      body: BlocConsumer<UserCubit, UserState>(
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
    double buttonWidth = MediaQuery.of(context).size.width / 3.5;

    final h50 = CustomSizedBox().h50();
    final h15 = CustomSizedBox().h15();

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          h50,
          const Text(
            "Reset your password",
            style: TextStyles.header,
          ),
          h50,
          SimpleTextField(
            controller: _emailController,
            labelText: "Enter your email",
          ),
          h50,
          GestureDetector(
            onTap: () => submitReset(),
            child: Button(
              width: buttonWidth,
              backgroundColor: AppColors.button,
              fontColor: AppColors.textColorWhite,
              text: "Recover",
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
                            context, PageConst.signInPage, ((route) => false)),
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Button(
                                text: "Log in",
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
