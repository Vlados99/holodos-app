import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:holodos/common/app_const.dart';

class SimpleTextField extends StatelessWidget {
  double? width;
  BuildContext context;
  TextEditingController controller;
  String? labelText;
  List<TextInputFormatter>? formatters;
  Icon? icon;

  SimpleTextField({
    Key? key,
    this.width,
    required this.context,
    required this.controller,
    this.labelText,
    this.formatters,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width - 30,
      child: TextField(
        inputFormatters:
            formatters ?? [FilteringTextInputFormatter.singleLineFormatter],
        cursorColor: AppColors.appBar,
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            icon: icon,
            labelText: labelText,
            labelStyle: TextStyles.text16gray,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.appBar))),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  double? width;
  BuildContext context;
  TextEditingController controller;
  String? labelText;
  List<TextInputFormatter>? formatters;
  Icon icon;

  PasswordTextField({
    Key? key,
    this.width,
    required this.context,
    required this.controller,
    this.labelText,
    this.formatters,
    required this.icon,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passenable = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width - 30,
      child: TextField(
        obscureText: passenable,
        enableSuggestions: false,
        autocorrect: false,
        inputFormatters: widget.formatters ??
            [FilteringTextInputFormatter.singleLineFormatter],
        cursorColor: AppColors.appBar,
        controller: widget.controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelStyle: TextStyles.text16gray,
          icon: widget.icon,
          labelText: widget.labelText,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.appBar),
          ),
          suffix: Container(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  passenable = passenable ? false : true;
                });
              },
              child: Icon(
                passenable == true ? Icons.remove_red_eye : Icons.password,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  double? width;
  BuildContext context;
  TextEditingController controller;
  String? labelText;
  List<TextInputFormatter>? formatters;
  Icon? icon;

  SearchTextField({
    Key? key,
    this.width,
    required this.context,
    required this.controller,
    this.labelText,
    this.formatters,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width - 30,
      child: TextField(
        inputFormatters:
            formatters ?? [FilteringTextInputFormatter.singleLineFormatter],
        cursorColor: AppColors.appBar,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyles.text16gray,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.appBar),
          ),
          suffix: Container(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.arrow_forward,
                size: 28,
                color: AppColors.dirtyGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
