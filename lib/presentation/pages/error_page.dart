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
        routeName: PageConst.errorPage,
        width: MediaQuery.of(context).size.width - 80,
      )),
      body: Container(
        alignment: Alignment.topCenter,
        child: const Text("Sorry but you got to a page with an error"),
      ),
    );
  }
}
