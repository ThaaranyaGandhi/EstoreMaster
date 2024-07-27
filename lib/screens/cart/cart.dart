import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/db/local_db.dart';
import 'package:fresh_store_ui/global.dart';
import 'package:fresh_store_ui/screens/auth/login/login.dart';
import 'package:fresh_store_ui/screens/cart/cart_header.dart';
import 'package:fresh_store_ui/screens/cart/cart_item.dart';

import '../../network/models/cart.dart';
import '../address/address.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static String route() => '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                backgroundColor: ColorsConst.firstColor,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: SafeArea(
                  child: CartAppBar(),
                ),
              ),
              SliverPadding(
                  // padding: padding,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) => Global.myCartItems.value.isNotEmpty
                          ? _buildBody(context, Global.myCartItems.value[index])
                          : Center(
                              child: Container(
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height - 300,
                                child: const Text("No items added",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24)),
                              ),
                            )),
                      childCount: Global.myCartItems.value.isNotEmpty
                          ? Global.myCartItems.value.length
                          : 1,
                    ),
                  )),
              const SliverAppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: SizedBox(height: 24))
            ],
          ),
          if (Global.myCartItems.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(15),
              child: buildAddCard(),
            )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, Cart cart) {
    return CartItem(cart: cart);
  }

  buildAddCard() => ValueListenableBuilder(
        valueListenable: Global.myCartItems,
        builder: (_, cartItems, __) {
          var totalItems = Global.calculateTotalItems(cartItems);
          var totalAmount =
              Global.calculateTotalAmount(cartItems).toStringAsFixed(2);

          return Container(
            color: Colors.white,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$totalItems Items',
                        style: const TextStyle(
                            color: Color(0xFF757575), fontSize: 12)),
                    const SizedBox(height: 6),
                    Text('\$ $totalAmount',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ],
                ),
                Container(
                  height: 58,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(29)),
                    color: ColorsConst.firstColor /*const Color(0xFF101010)*/,
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
                      onTap: () {
                     //   Navigator.pushNamed(context, AddressScreen.route());

                        if (LocalDB.getUserid() == null) {
                          Navigator.pushNamed(context, LoginScreen.route());
                        } else {
                          Navigator.pushNamed(context, AddressScreen.route());
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/detail/bag@2x.png',
                              color: Colors.black87, scale: 1.5),
                          const SizedBox(width: 10),
                          const Text(
                            'Order',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
}
