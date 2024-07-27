import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/screens/InfoVIew.dart';
import 'package:fresh_store_ui/screens/address/add_address.dart';
import 'package:fresh_store_ui/screens/address/address.dart';
import 'package:fresh_store_ui/screens/address/bloc/address_bloc.dart';
import 'package:fresh_store_ui/screens/address/my_address.dart';
import 'package:fresh_store_ui/screens/auth/bloc/auth_bloc.dart';
import 'package:fresh_store_ui/screens/cart/cart.dart';
import 'package:fresh_store_ui/screens/detail/detail_screen.dart';
import 'package:fresh_store_ui/screens/home/bloc/home_bloc.dart';
import 'package:fresh_store_ui/screens/home/home.dart';
import 'package:fresh_store_ui/screens/auth/login/login.dart';
import 'package:fresh_store_ui/screens/mostpopular/bloc/product_bloc.dart';
import 'package:fresh_store_ui/screens/mostpopular/most_popular_screen.dart';
import 'package:fresh_store_ui/screens/order/bloc/order_bloc.dart';
import 'package:fresh_store_ui/screens/order/order.dart';
import 'package:fresh_store_ui/screens/order/order_list.dart';
import 'package:fresh_store_ui/screens/order/order_success.dart';
import 'package:fresh_store_ui/screens/payment/choose_payment.dart';
import 'package:fresh_store_ui/screens/profile/profile_screen.dart';
import 'package:fresh_store_ui/screens/auth/signup/signup_screen.dart';
import 'package:fresh_store_ui/screens/profile/view_profile.dart';
import 'package:fresh_store_ui/screens/search/bloc/search_bloc.dart';
import 'package:fresh_store_ui/screens/search/search_screen.dart';
import 'package:fresh_store_ui/screens/special_offers/special_offers_screen.dart';
import 'package:fresh_store_ui/screens/splash/splash.dart';
import 'package:fresh_store_ui/screens/tabbar/tabbar.dart';
import 'package:fresh_store_ui/screens/test/test_screen.dart';
import 'package:fresh_store_ui/screens/webview/html.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.route(): (context) => BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScreen(title: '123'),
      ),
  MostPopularScreen.route(): (context) => BlocProvider(
        create: (context) => ProductBloc(),
        child: const MostPopularScreen(),
      ),
  SpecialOfferScreen.route(): (context) => const SpecialOfferScreen(),
  AddressScreen.route(): (context) => BlocProvider(
        create: (context) => AddressBloc(),
        child: const AddressScreen(),
      ),
  ChoosePaymentScreen.route(): (context) => const ChoosePaymentScreen(),
  AddAddressScreen.route(): (context) { 

      

      return BlocProvider(
        create: (context) => AddressBloc(),
        child: const AddAddressScreen(),
      );
  },
  ProfileScreen.route(): (context) => const ProfileScreen(),
  ShopDetailScreen.route(): (context) => const ShopDetailScreen(),
  ViewProfileScreen.route(): (context) => const ViewProfileScreen(),
  TestScreen.route(): (context) => const TestScreen(),
  HtmlScreen.route(): (context) => const HtmlScreen(),
  OrderScreen.route(): (context) => BlocProvider(
        create: (context) => OrderBloc(),
        child: const OrderScreen(),
      ),
  OrderListScreen.route(): (context) => BlocProvider(
        create: (context) => OrderBloc()..add(OrderHistory()),
        child: OrderListScreen(true),
      ),
  OrderSuccessScreen.route(): (context) => const OrderSuccessScreen(),
  MyAddressScreen.route(): (context) => const MyAddressScreen(),
  SearchScreen.route(): (context) => BlocProvider(
        create: (context) => SearchBloc(),
        child: const SearchScreen(),
      ),
  LoginScreen.route(): (context) => BlocProvider(
        create: (context) => AuthBloc(),
        child: const LoginScreen(),
      ),
  SignupScreen.route(): (context) => BlocProvider(
        create: (context) => AuthBloc(),
        child: const SignupScreen(),
      ),
  SplashScreen.route(): (context) => const SplashScreen(),
  InfoviewScreen.route(): (context) => InfoviewScreen(''),
  FRTabbarScreen.route(): (context) => const FRTabbarScreen(),
  CartScreen.route(): (context) => const CartScreen()
};
