import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fresh_store_ui/routes.dart';
import 'package:fresh_store_ui/screens/splash/splash.dart';
import 'package:fresh_store_ui/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //live
  Stripe.publishableKey = 'pk_live_51NPerSBt762Qp9SFTL2cSkhdI9ZrGKjMxocCRmNiVNwlBp4QGHah3MS2ESX8fePaO9STvUr98zmnSmscAwRIO6KO00DrKQMSQw';
  //test
  //Stripe.publishableKey = 'pk_test_51Nk5DbSGhA9IRycBm4ltiJFubpgxPAngBA7JX40pYy7qiqBglsOeYhNIZ6dD90LvXlu6WQHHPRspIRb765qrmGnN00h9FhFVvS';
  await Hive.initFlutter();
  await Hive.openBox('user');
  runApp(const FreshBuyerApp());
}

class FreshBuyerApp extends StatelessWidget {
  const FreshBuyerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fresh-Buyer',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: appTheme(),
      routes: routes,
      home: const SplashScreen(),
    );
  }
}
