import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';

import '../network/models/product.dart';
import '../utils/calculations.dart';

typedef ProductCardOnTaped = void Function(Product data);

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.data, this.ontap});

  final Product data;
  final ProductCardOnTaped? ontap;

  @override
  Widget build(BuildContext context) {
    // final data = datas[index % datas.length];
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return InkWell(
      borderRadius: borderRadius,
      onTap: () => ontap?.call(data),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 100,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration:  BoxDecoration(
              borderRadius: borderRadius,
              color: ColorsConst.secondColor,
            //  color: Color(0xFFeeeeee),
            ),
            child: Image.network(
              data.productImage,
              width: 120,
              height: 120,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            data.productName,
            maxLines: 2,
            style: const TextStyle(
              color: Color(0xFF212121),
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          _buildSoldPoint(data.price[0].productPrice, data.discount),
          const SizedBox(height: 5),
          Text(
            '\$${Calculations.calculateDiscountedPrice(data.price[0].productPrice, data.discount)}',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121)),
          )
        ],
      ),
    );
  }

  Widget _buildSoldPoint(String productPrice, String discount) {
    return Row(
      children: [
        Text(
          '\$$productPrice',
          style: const TextStyle(
            color: Color(0xFF616161),
            fontSize: 14,
            decoration: TextDecoration.lineThrough,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          '|',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF616161),
              fontSize: 14),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color:ColorsConst.secondColor/*const Color(0xFF101010).withOpacity(0.08)*/,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text(
            '$discount % Off',
            style: const TextStyle(
              color: Color(0xFF35383F),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
