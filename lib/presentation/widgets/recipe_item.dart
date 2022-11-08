import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/recipe/recipe_cubit.dart';

import '../../common/storage.dart';

double height = 200;

Widget RecipeItem(
    {required BuildContext context,
    required RecipeLoaded state,
    required int index}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageConst.recipePage,
            arguments: state.recipes[index]);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: AppColors.black),
        )),
        alignment: AlignmentDirectional.center,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.orange,
                border: Border(
                  bottom: BorderSide(color: AppColors.black),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "${state.recipes[index].name}",
                style: TextStyles.text32White,
              ),
            ),
            Stack(
              children: [
                Container(
                  child: buildResults(
                      context, "recipes", state.recipes[index].imgUri),
                ),
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                      colors: [
                        Colors.white.withOpacity(0.0),
                        AppColors.mainBackground,
                      ],
                      stops: [
                        0.1,
                        0.5,
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: FractionalOffset.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      txt("Cook time: ${state.recipes[index].cookTime} min",
                          TextStyles.text16black),
                      txt("Complexity: ${state.recipes[index].complexity}",
                          TextStyles.text16black),
                      txt("Serves: ${state.recipes[index].serves}",
                          TextStyles.text16black),
                      txt("Cuisines: ${state.recipes[index].cuisines}",
                          TextStyles.text16black),
                    ],
                  ),
                ),
              ],
            ),
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
          height: height,
        );
      }
    }),
  );
}

Widget txt(String text, TextStyle style) {
  return Container(
    height: 32,
    child: Text(
      text,
      style: style,
    ),
  );
}
