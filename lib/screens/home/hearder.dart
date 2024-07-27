import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/db/local_db.dart';
import 'package:fresh_store_ui/screens/cart/cart.dart';

import '../../global.dart';
import '../../image_loader.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
               'Hello ${LocalDB.getUserName() ?? 'Guest'} 👋',
               style: const TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.w600,
                 fontSize: 20
               ),
                              ),
            ),
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
                   // iconSize: 18,
                    icon: Image.asset(
                      '${ImageLoader.rootPaht}/tabbar/light/Bag@2x.png',
                      color: ColorsConst.black,
                      height: 30
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, CartScreen.route());
                    },
                  ),
                );
              }),

          // const SizedBox(width: 16),
          // IconButton(
          //   iconSize: 28,
          //   icon: Image.asset('$kIconPath/light/heart@2x.png'),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}
