import 'package:flutter/material.dart';

class MyOrderAppBar extends StatelessWidget {
  const MyOrderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 35, left: 15),
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
            child: Text(
              'My Orders',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
              textAlign: TextAlign.start,
            ),
          ),
          // const SizedBox(width: 16),
          // ValueListenableBuilder(
          //   valueListenable: Global.myCartItems,
          //   builder: (_, cartItems, __) {
          //     var totalItems = Global.calculateTotalItems(cartItems);

          //     return Badge(
          //         offset: const Offset(-2, -2),
          //         backgroundColor: const Color(0xFFf3f3f3),
          //         isLabelVisible: totalItems>0,
          //         label: Text('$totalItems', style: Theme.of(context).textTheme.labelLarge,),
          //         child: IconButton(
          //           iconSize: 28,
          //           icon: Image.asset('${ImageLoader.rootPaht}/tabbar/light/Bag@2x.png', color: ColorsConst.black,),
          //           onPressed: () {
          //             Navigator.pushNamed(context, CartScreen.route());
          //           },
          //         ),
          //     );
          //   }
          // ),
        ],
      ),
    );
  }
}
