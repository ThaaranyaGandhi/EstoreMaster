import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/image_loader.dart';
import 'package:fresh_store_ui/screens/cart/cart.dart';
import 'package:fresh_store_ui/screens/home/home.dart';
import 'package:fresh_store_ui/screens/order/bloc/order_bloc.dart';
import 'package:fresh_store_ui/screens/order/order_list.dart';
import 'package:fresh_store_ui/screens/profile/profile_screen.dart';
import 'package:fresh_store_ui/size_config.dart';

import '../home/bloc/home_bloc.dart';

class TabbarItem {
  final String lightIcon;
  final String boldIcon;
  final String label;

  TabbarItem(
      {required this.lightIcon, required this.boldIcon, required this.label});

  BottomNavigationBarItem item(bool isbold) {
    return BottomNavigationBarItem(
      icon: ImageLoader.imageAsset(isbold ? boldIcon : lightIcon),
      label: label,
    );
  }

  BottomNavigationBarItem get light => item(false);
  BottomNavigationBarItem get bold => item(true);
}

class FRTabbarScreen extends StatefulWidget {
  const FRTabbarScreen({super.key});

  static String route() => '/tabbar';

  @override
  State<FRTabbarScreen> createState() => _FRTabbarScreenState();
}

class _FRTabbarScreenState extends State<FRTabbarScreen> {
  int _select = 0;

  final screens = [
    BlocProvider(
      create: (context) => HomeBloc(),
      child: const HomeScreen(
        title: '首页0',
      ),
    ),
    const CartScreen(),
    BlocProvider(
      create: (context) => OrderBloc()..add(OrderHistory()),
      child:  OrderListScreen(false),
    ),
    const ProfileScreen(),
  ];

  static Image generateIcon(String path) {
    return Image.asset(
      '${ImageLoader.rootPaht}/tabbar/$path',
      width: 24,
      height: 24,
    );
  }

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: generateIcon('light/Home@2x.png'),
     activeIcon: generateIcon('bold/Home@2x.png'),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Bag@2x.png'),
     activeIcon: generateIcon('bold/Bag@2x.png'),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Buy@2x.png'),
      activeIcon: generateIcon('bold/Buy@2x.png'),
      label: 'Orders',
    ),
    // BottomNavigationBarItem(
    //   icon: generateIcon('light/Wallet@2x.png'),
    //   activeIcon: generateIcon('bold/Wallet@2x.png'),
    //   label: 'Wallet',
    // ),
    BottomNavigationBarItem(
      icon: generateIcon('light/Profile@2x.png'),
      activeIcon: generateIcon('bold/Profile@2x.png'),
      label: 'Profile',
    ),
  ];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        body: screens[_select],
        bottomNavigationBar: BottomNavigationBar(
        //  fixedColor: Colors.red,
          backgroundColor: Colors.red.shade100, // Change background color here
       //   selectedItemColor: Colors.red, // Change selected icon color here
          unselectedItemColor: Colors.black54,
        //  backgroundColor: Colors.red.shade100,
          items: items,
          onTap: ((value) => setState(() => _select = value)),
          currentIndex: _select,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
     //     selectedItemColor: Colors.red,
         //selectedIconTheme: const IconThemeData(color: Colors.red),
         selectedItemColor: const Color(0xFF212121),
     //     unselectedItemColor: const Color(0xFF9E9E9E),
        ),
      ),
    );
  }
}
