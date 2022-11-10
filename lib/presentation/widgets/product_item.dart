import 'package:flutter/cupertino.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/product/product_cubit.dart';

Widget ProductItem({required ProductLoaded state, required int index}) {
  return Container(
    padding: EdgeInsets.only(bottom: 8, left: 10),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          AppColors.button,
          AppColors.mainBackground,
        ],
        stops: [
          0.1,
          0.7,
        ],
      ),
    ),
    child: Text(
      "${state.products[index].name}",
      style: TextStyles.text32black,
    ),
  );
}
