import 'package:flutter/material.dart';

import '../../constants/colors_const.dart';
import '../../global.dart';
import '../../image_loader.dart';
import '../cart/cart.dart';

class OrderAppBar extends StatelessWidget {
  const OrderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // InkWell(
          //   borderRadius: const BorderRadius.all(Radius.circular(24)),
          //   onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
          //   child: const CircleAvatar(
          //     backgroundImage: AssetImage('$kIconPath/me.png'),
          //     radius: 24,
          //   ),
          // ),
          const Expanded(
            child: Text(
                  'Placed Order',
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
          ),
          const SizedBox(width: 16),
          ValueListenableBuilder(
            valueListenable: Global.myCartItems,
            builder: (_, cartItems, __) {
              var totalItems = Global.calculateTotalItems(cartItems);

              return Badge(
                  offset: const Offset(-2, -2),
                  backgroundColor: const Color(0xFFf3f3f3),
                  isLabelVisible: totalItems>0,
                  label: Text('$totalItems', style: Theme.of(context).textTheme.labelLarge,),
                  child: IconButton(
                    iconSize: 28,
                    icon: Image.asset('${ImageLoader.rootPaht}/tabbar/light/Bag@2x.png', color: ColorsConst.black,),
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.route());
                    },
                  ),
              );
            }
          ),
        ],
      ),
    );
  }
}
