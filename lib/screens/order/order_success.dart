import 'package:flutter/material.dart';
import 'package:fresh_store_ui/screens/order/order_list.dart';
import 'package:fresh_store_ui/screens/tabbar/tabbar.dart';

import '../../constants/assets_const.dart';
import '../../global.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  static String route() => '/orderSuccess';

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {

  @override
  void initState() {
    Global.myCartItems.value = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pushNamed(context, FRTabbarScreen.route());
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AssetsConst.appLogo))
                ),
              ),
        
              const Text(
                'Congratulation!',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
    
              const SizedBox(height: 24,),
    
              const Text(
                    'Thank you for ordering. We received your order and will begin processing it soon',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 18,
                      height: 1.4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
        
    
              const SizedBox(height: 24,),
              
              Container(
                height: 58,
                width: double.infinity,
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
                    onTap: () {
                      Navigator.pushNamed(context, OrderListScreen.route());

                    },
                    child: const Center(
                      child: Text(
                            'Track your order',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              )
        
            ],
          ),
        ),
      ),
    );
  }
}