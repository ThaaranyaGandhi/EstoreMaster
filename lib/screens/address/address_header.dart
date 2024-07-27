import 'package:flutter/material.dart';

import '../../constants/colors_const.dart';
import '../../global.dart';
import '../../image_loader.dart';
import '../cart/cart.dart';

class AddressAppBar extends StatelessWidget {
  const AddressAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Image.asset('assets/icons/back@2x.png', scale: 2),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                'Place Order',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          ValueListenableBuilder(
              valueListenable: Global.myCartItems,
              builder: (_, cartItems, __) {
                var totalItems = Global.calculateTotalItems(cartItems);

                return Badge(
                  offset: const Offset(-2, -2),
                  backgroundColor: const Color(0xFFf3f3f3),
                  isLabelVisible: totalItems > 0,
                  label: Text(
                    '$totalItems',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      '${ImageLoader.rootPaht}/tabbar/light/Bag@2x.png',
                      color: ColorsConst.black,
                      height: 30,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.route());
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
