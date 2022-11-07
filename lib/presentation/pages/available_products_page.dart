import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Holodos")),
      body: Container(
        alignment: Alignment.topCenter,
        child: Text("${context.toString()}"),
      ),
    );
  }
}
