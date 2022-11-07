import 'package:flutter/material.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: "Error"),
      body: Container(
        alignment: Alignment.topCenter,
        child: Text("${context.toString()}"),
      ),
    );
  }
}
