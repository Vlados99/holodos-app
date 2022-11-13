import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/widgets/app_bar.dart';
import 'package:holodos/presentation/widgets/drawer.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Error"),
      drawer: SafeArea(
          child: AppDrawer(
              routeName: PageConst.recipesPage,
              width: MediaQuery.of(context).size.width - 80,
              context: context)),
      body: Container(
        alignment: Alignment.topCenter,
        child: Text("${context.toString()}"),
      ),
    );
  }
}
