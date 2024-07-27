import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/assets_const.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/network/models/address.dart';
import 'package:fresh_store_ui/screens/order/order.dart';
import 'package:fresh_store_ui/screens/payment/header.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import '../../global.dart';
import 'package:http/http.dart' as http;

import 'Stripe_Model.dart';

class ChoosePaymentScreen extends StatefulWidget {
  const ChoosePaymentScreen({super.key});

  static String route() => '/payment';

  @override
  State<ChoosePaymentScreen> createState() => ChoosePaymentScreenState();
}

class ChoosePaymentScreenState extends State<ChoosePaymentScreen> {
  bool doneLoading = false;
  late Stripe_Model stripeinfo;
  static Address? address;
  @override
  void initState() {
    //doneLoading = false;
    super.initState();
    Future.delayed(Duration.zero, () {
      callService();
    });
  }


  @override
  Widget build(BuildContext context) {
    print('mghgh');
    print(address?.pincode);
    print(Global.calculateTotalAmount(Global.myCartItems.value).toStringAsFixed(2));

    return Scaffold(
      body: doneLoading == false ? Center(child: CircularProgressIndicator(color: Colors.grey,)) : Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: <Widget>[
              const SliverPadding(
                padding: EdgeInsets.only(top: 24),
                sliver: SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: PaymentAppBar(),
                ),
              ),
              SliverPadding(
                // padding: padding,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) => _buildBody(context, Global.myAddress.value[index])),
                      childCount: 1,
                    ),
                  )
              ),
              const SliverAppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: SizedBox(height: 24))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, Address address) {
    const borderRadius = BorderRadius.all(Radius.circular(20));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40,),
        Center(
          child: Image.asset(AssetsConst.bag,width: 150,height: 150,),
        ),
        // Container(
        // margin: const EdgeInsets.only(bottom: 24),
        // padding: const EdgeInsets.all(4),
        // decoration: const BoxDecoration(
        //   borderRadius: borderRadius,
        //   color: ColorsConst.primary,
        // ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     // const Padding(
        //     //   padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
        //     //   child: Text('Delivery By', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white))),
        //     // const SizedBox(height: 16,),
        //     // RadioListTile(
        //     //   value: true,
        //     //   groupValue: true,
        //     //   onChanged: (v){},
        //     //   title: Text('${Global.timeSlot?.mintime} - ${Global.timeSlot?.maxtime}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
        //     // )
        //   ],
        // )),
        SizedBox(height: 40,),

        Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          borderRadius: borderRadius,
          color: Color(0xFFeeeeee),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF212121)))),
            const SizedBox(height: 16,),
            InkWell(
              onTap: (){
                OrderScreenState.paymentype = "Cash On Delivery";
                Navigator.pushNamed(context, OrderScreen.route());
              },
              child: ListTile(
                leading: Image.asset(AssetsConst.cod),
                title: const Text('Cash On Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF212121))),
              ),
            ),
            InkWell(
              onTap: () async {
                //await stripe.Stripe.instance.presentPaymentSheet();
                handlePayment();
                //_displayPaymentSheet();
              },
              child: ListTile(
                leading: Image.asset('assets/icons/stripe.png',width: 50,height: 50,),
                title: const Text('Pay Online', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF212121))),
              ),
            ),

          ],
        )),

      ],
    );
  }

  Future<void> handlePayment() async {
    try {
      // Assuming you have already initialized the payment sheet
      // Display the payment sheet
      await stripe.Stripe.instance.presentPaymentSheet();
      print('success');
      // Payment is successful
      // Perform post-payment success operations here
      OrderScreenState.paymentype = "Pay Online";
      Navigator.pushNamed(context, OrderScreen.route());

    } catch (e) {
      // Handle errors or cancellations
      if (e is stripe.StripeException) {
        if (e.error.code == 'Canceled') {
          // User cancelled the payment sheet
          print('Payment cancelled');
        } else {
          // Payment failed due to other reasons
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment failed: ${e.error.localizedMessage}')),
          );
        }
      } else {
        // Other exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred')),
        );
      }
    }
  }


  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await stripeinfo;

      // 2. initialize the payment sheet
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'SK Paper Product',
          paymentIntentClientSecret: data.paymentIntent,
          // Customer keys
          customerEphemeralKeySecret: data.ephemeralKey,
          customerId: data.customer,
          // Extra options
          style: ThemeMode.dark,

        ),
      );
    } catch (e) {
      if (e is stripe.StripeException && e.error.code != 'Canceled') {
        // Handle errors (excluding user cancellation)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: ${e.error.localizedMessage}')),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),

      );
      rethrow;
    }
  }
  Future<String> fetchPaymentIntentIdFromServer(String paymentIntentClientSecret) async {
    // Implement the logic to fetch the payment intent ID from the server
    // This might involve making a request to your server with the paymentIntentClientSecret
    // Replace this with your actual server request
    await Future.delayed(Duration(seconds: 2));
    return 'your_payment_intent_id';
  }

  void callService()async{
    double number = double.parse(Global.calculateTotalAmount(Global.myCartItems.value).toStringAsFixed(2)) * 100;
    print("Parsed integer: $number");
    int myInt = number.toInt();

    var request = http.MultipartRequest('POST', Uri.parse('https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/stripe_api.php'));
    request.fields.addAll({
      'amount': myInt.toString(),
      'name': address?.name ?? '',
      'society': address?.society ?? '',
      'pincode' : address?.pincode ?? '',
      'hno' : address?.no ?? '',
      'city' : 'San Francisco',
      'state' : 'CA',
      'country' : 'US'
    });
    print(request.fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print(responseBody);

      // Now you can use responseBody without trying to listen to the stream again
      var jsonList = jsonDecode(responseBody);
      stripeinfo = Stripe_ModelModelFromJson(responseBody);

      doneLoading = true;
      setState(() {
        initPaymentSheet();
      });
    }
    else {
      doneLoading = true;
      setState(() {

      });
      print(response.reasonPhrase);
    }
  }

  Future<Post> createPost(String url, {required Map body}) async {
    return http.post(Uri.parse(url), body: body).then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(response.statusCode);
        throw new Exception("Error while fetching dataffff");
      }
      print(response.statusCode);
      print("sss" + response.body);
      var jsonList = jsonDecode(response.body);
       stripeinfo = Stripe_ModelModelFromJson(response.body);
       print(stripeinfo.customer);

      doneLoading = true;
      setState(() {
        initPaymentSheet();
      });
      //print("Response:${response.body}")
      return Post.fromJson(json.decode(response.body));
    });
  }

}

class Post {
  final String amount;


  Post({required this.amount});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      amount: json['amount'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["amount"] = amount;
    return map;
  }
}