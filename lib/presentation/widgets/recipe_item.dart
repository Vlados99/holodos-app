import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';

import '../../common/storage.dart';

Widget RecipeItem(
    {required BuildContext context,
    required RecipeLoaded state,
    required int index}) {
  return Container(
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageConst.recipePage,
            arguments: state.recipes[index]);
      },
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
        alignment: AlignmentDirectional.center,
        child: Column(
          children: [
            Text(
              "${state.recipes[index].name}",
              style: TextStyles.text32black,
            ),
            txt("Cook time: ${state.recipes[index].cookTime} min",
                TextStyles.text16black),
            txt("Complexity: ${state.recipes[index].complexity}",
                TextStyles.text16black),
            txt("Serves: ${state.recipes[index].serves}",
                TextStyles.text16black),
            txt("Cuisines: ${state.recipes[index].cuisines}",
                TextStyles.text16black),
            buildResults(context, "recipes", state.recipes[index].imgUri),
          ],
        ),
      ),
    ),
  );
}

Widget buildResults(BuildContext context, String dir, String imgName) {
  return FutureBuilder(
    future: Storage.getImage(dir, imgName),
    builder: ((context, AsyncSnapshot<String> snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return CircularProgressIndicator();
      } else {
        return Image.network(
          snapshot.data!,
          width: 100,
          height: 100,
        );
      }
    }),
  );
}

Widget txt(String text, TextStyle style) {
  return Text(
    text,
    style: style,
  );
}
