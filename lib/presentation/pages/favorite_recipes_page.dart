import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteRecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite recipes")),
      body: Container(
        alignment: Alignment.topCenter,
        child: Text("${context.toString()}"),
      ),
    );
  }
}
