import 'package:flutter/material.dart';
import 'package:holodos/presentation/widgets/appbar/app_bar.dart';

class ErrorPage extends StatelessWidget {
  final String? title;
  final String? message;
  const ErrorPage({Key? key, this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: title ?? "Error"),
      body: Center(
        child: Text(message ?? "Sorry but you got to a page with an error"),
      ),
    );
  }
}
