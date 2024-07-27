import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/network/models/order_history.dart';
import 'package:fresh_store_ui/screens/order/bloc/order_bloc.dart';
import 'package:fresh_store_ui/screens/order/history_item.dart';
import 'package:fresh_store_ui/screens/order/my_order_header.dart';

import '../tabbar/tabbar.dart';

class OrderListScreen extends StatefulWidget {
  static String route() => '/orderList';
  bool trackorder;

  OrderListScreen(this.trackorder);

  @override
  State<OrderListScreen> createState() {
    return OrderListScreenState(this.trackorder);
  }
}

class OrderListScreenState extends State<OrderListScreen> {
  var orders = [];
  bool trackorder;

  OrderListScreenState(this.trackorder);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: ColorsConst.firstColor,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: trackorder
                ? AppBar(
                    title: const Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text(
                        'My Orders',
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    leading: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, FRTabbarScreen.route(), (route) => false),
                    ),
                  )
                : const MyOrderAppBar(),
          ),
          BlocBuilder<OrderBloc, OrderState>(builder: (_, state) {
            if (state is OrderHistoryFetched) {
              orders = state.history;
            }

            return SliverPadding(
                // padding: padding,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    ((context, index) => orders.isNotEmpty
                        ? _buildBody(context, orders[index])
                        : Center(
                            child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height - 300,
                            child: const Text("No items added",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24)),
                          ))),
                    childCount: orders.isNotEmpty ? orders.length : 1,
                  ),
                ));
          }),
          const SliverAppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: SizedBox(height: 24))
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, OrderHistoryModel history) {
    return HistoryItem(history: history);
  }
}
