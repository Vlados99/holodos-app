import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/domain/entities/product_entity.dart';

class ProductItem extends StatefulWidget {
  final ProductEntity product;

  const ProductItem({
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
      padding: const EdgeInsets.only(bottom: 8, left: 20),
      decoration: const BoxDecoration(color: AppColors.mainBackground),
      child: txt(name: name, unit: unit),
    );
  }

  Widget txt({required String name, String? unit}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.orange, width: 1),
            ),
          ),
          child: Text(
            unit != "" ? "$name - $unit" : name,
            style: TextStyles.productTextStyle,
          ),
        ),
      ],
    );
  }
}
