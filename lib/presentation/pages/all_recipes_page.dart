import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
