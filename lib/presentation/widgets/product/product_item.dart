import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/product_entity.dart';

class ProductItem extends StatefulWidget {
  final ProductEntity product;

  ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return productItem(name: widget.product.name, unit: widget.product.unit);
  }

  Widget productItem({String? unit, required String name}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 8, left: 10),
      decoration: const BoxDecoration(color: AppColors.orange),
      child: txt(name: name, unit: unit),
    );
  }

  Widget txt({required String name, String? unit}) {
    return Row(
      children: [
        Text(
          name,
          style: TextStyles.text32black,
        ),
        unit != ""
            ? Text(
                " - $unit",
                style: TextStyles.text32black,
              )
            : Container(),
      ],
    );
  }
}
