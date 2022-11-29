import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:holodos/common/app_const.dart';

class SimpleTextField extends StatefulWidget {
  final double? width;
  final TextEditingController controller;
  final String? labelText;
  final List<TextInputFormatter>? formatters;
  final Icon? icon;

  const SimpleTextField({
    Key? key,
    this.width,
    required this.controller,
    this.labelText,
    this.formatters,
    this.icon,
  }) : super(key: key);

  @override
  State<SimpleTextField> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width - 30,
      child: TextField(
        inputFormatters: widget.formatters ??
            [FilteringTextInputFormatter.singleLineFormatter],
        cursorColor: AppColors.orange,
        controller: widget.controller,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black)),
          icon: widget.icon,
          labelText: widget.labelText,
          labelStyle: TextStyles.text16gray,
        ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final double? width;
  final BuildContext context;
  final TextEditingController controller;
  final String? labelText;
  final List<TextInputFormatter>? formatters;
  final Icon? icon;

  const PasswordTextField({
    Key? key,
    this.width,
    required this.context,
    required this.controller,
    this.labelText,
    this.formatters,
    this.icon,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passenable = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width - 30,
      child: TextField(
        obscureText: passenable,
        obscuringCharacter: "*",
        enableSuggestions: false,
        autocorrect: false,
        inputFormatters: widget.formatters ??
            [FilteringTextInputFormatter.singleLineFormatter],
        cursorColor: AppColors.orange,
        controller: widget.controller,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black)),
          labelStyle: TextStyles.text16gray,
          icon: widget.icon,
          labelText: widget.labelText,
          suffix: Container(
            padding: const EdgeInsets.only(right: 10),
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
  final double? width;
  final BuildContext context;
  final TextEditingController controller;
  final String? labelText;
  final List<TextInputFormatter>? formatters;
  final Icon? icon;

  const SearchTextField({
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
    return SizedBox(
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
            padding: const EdgeInsets.only(right: 10),
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
