import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/network/models/order_product.dart';
import 'package:fresh_store_ui/screens/order/bloc/order_bloc.dart';
import 'package:fresh_store_ui/screens/order/header.dart';
import 'package:fresh_store_ui/screens/order/order_item.dart';

import '../../global.dart';
import '../../network/models/cart.dart';
import 'order_success.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  static String route() => '/order';

  @override
  State<OrderScreen> createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  @override
  static var paymentype;
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if(state is OrderCreated){
          Global.myCartItems.value = [];
          Future.delayed(const Duration(milliseconds: 400), (){
            Navigator.pushNamed(context, OrderSuccessScreen.route());
          });
        }
      },
      child: paymentype == "Pay Online" ? WillPopScope(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  const SliverPadding(
                    padding: EdgeInsets.only(top: 24),
                    sliver: SliverAppBar(
                      backgroundColor: ColorsConst.firstColor,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      flexibleSpace: OrderAppBar(),
                    ),
                  ),
                  SliverPadding(
                      // padding: padding,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          ((context, index) => _buildBody(
                              context, Global.myCartItems.value[index])),
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
                  padding: const EdgeInsets.all(24),
                  child: buildAddCard(),
                )
            ],
          ),
        ),
        onWillPop: () async => false,
      ) : Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CustomScrollView(
              slivers: <Widget>[
                const SliverPadding(
                  padding: EdgeInsets.only(top: 24),
                  sliver: SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    flexibleSpace: OrderAppBar(),
                  ),
                ),
                SliverPadding(
                  // padding: padding,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        ((context, index) => _buildBody(
                            context, Global.myCartItems.value[index])),
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
                padding: const EdgeInsets.all(24),
                child: buildAddCard(),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Cart cart) {
    return OrderItem(cart: cart);
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
                    borderRadius: const BorderRadius.all(Radius.circular(29)),
                    color:  ColorsConst.firstColor,
                    border: Border.all(color: Colors.black,width: 1),
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
                        var i = 1;
                        var orderProducts = Global.myCartItems.value
                            .map((e) => OrderProduct(
                                id: '{$i++}',
                                pid: e.product.id,
                                image: e.product.productImage,
                                title: e.product.productName,
                                weight: e.productType,
                                cost: "${e.amount}",
                                qty: "${e.noOfItems}"))
                            .toList();

                        context.read<OrderBloc>().add(CreateOrder(
                            ddate: "${DateTime.now().add(const Duration(days: 1))}",
                            addressId: "1",
                            products: orderProducts,
                            total: Global.calculateTotalAmount(cartItems), ordertype: paymentype));
                        // Navigator.pushNamed(context, OrderSuccessScreen.route());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icons/detail/bag@2x.png',color: Colors.black,
                              scale: 1.5),
                          const SizedBox(width: 10),
                          const Text(
                            'Checkout',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
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
