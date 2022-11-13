import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';

class ProductItem extends StatelessWidget {
  String name;

  ProductItem({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productItem(name: name);
  }

  Widget productItem({required String name}) {
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
        "${name}",
        style: TextStyles.text32black,
      ),
    );
  }
}
