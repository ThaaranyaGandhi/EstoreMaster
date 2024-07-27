import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../global.dart';
import '../../network/models/cart.dart';
import '../../network/models/product.dart';
import '../../size_config.dart';
import '../../utils/calculations.dart';

class OrderItem extends StatefulWidget {
  final Cart cart;
  const OrderItem({super.key, required this.cart});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late Product product;
  late Price price;
  late int noofItems;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    product = widget.cart.product;
    price = widget.cart.product.price[0];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        borderRadius: borderRadius,
        color: Color(0xFFeeeeee),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            decoration: const BoxDecoration(
              borderRadius: borderRadius,
              color: Color(0xFFeeeeee),
            ),
            child: Image.network(
              product.productImage,fit: BoxFit.fitHeight,width: 100,height: 100,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 6, 6, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._buildTitle(),
                  const SizedBox(height: 16),
                  // _buildLine(),
                  // const SizedBox(height: 16),
                  // ..._buildDescription(),
                  // const SizedBox(height: 24),
                  // _buildQuantity()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildTitle() {
    return <Widget>[
      Text(
        product.productName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     FittedBox(
      //       child: Text(
      //         product.productName,
      //         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: () => setState(() => _iscollected = !_iscollected),
      //       icon: Image.asset('assets/icons/${_iscollected ? 'bold' : 'light'}/heart@2x.png'),
      //       iconSize: 28,
      //     ),
      //   ],
      // ),
      const SizedBox(height: 10),
      Text(
        '\$${Calculations.calculateDiscountedPrice(price.productPrice, product.discount)}',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
      )
      // Row(
      //   children: [
      //     Container(
      //       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      //       decoration: const BoxDecoration(
      //         borderRadius: BorderRadius.all(Radius.circular(6)),
      //         color: Color(0xFFeeeeee),
      //       ),
      //       child: const Text(
      //         '9,742 sold',
      //         style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      //       ),
      //     ),
      //     const SizedBox(width: 16),
      //     Image.asset('assets/icons/start@2x.png', height: 20, width: 20),
      //     const SizedBox(width: 8),
      //     const Text(
      //       '4.8 (6,573 reviews)',
      //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      //     ),
      //   ],
      // ),
    ];
  }

  Widget _buildLine() {
    return Container(height: 1, color: const Color(0xFFEEEEEE));
  }

  List<Widget> _buildDescription() {
    return [
      const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ExpandableText(
        product.shortDesc,
        expandText: 'view more',
        collapseText: 'view less',
        linkStyle: const TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold),
      ),
    ];
  }

  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: getProportionateScreenWidth(208),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: const Color(0xFF101010),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/detail/bag@2x.png', scale: 2),
                  const SizedBox(width: 16),
                  const Text(
                    'View Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ValueListenableBuilder(
        valueListenable: Global.myCartItems,
        builder: (_, OrderItems, __){

          var totalItems = Global.calculateTotalItems(OrderItems);
          var totalAmount = Global.calculateTotalAmount(OrderItems).toStringAsFixed(2);

          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _buildLine(),
                const SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$totalItems Items', style: const TextStyle(color: Color(0xFF757575), fontSize: 12)),
                        const SizedBox(height: 6),
                        Text('\$ $totalAmount', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                      ],
                    ),
                    buildAddCard()
                  ],
                ),
                const SizedBox(height: 36),
              ],
            ),
          );
        },
      ),
    );
  }
}