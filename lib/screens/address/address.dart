import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/network/models/address.dart';
import 'package:fresh_store_ui/screens/address/add_address.dart';
import 'package:fresh_store_ui/screens/address/address_item.dart';
import 'package:fresh_store_ui/screens/payment/choose_payment.dart';

import '../../db/local_db.dart';
import '../../global.dart';
import '../../network/services/address_service.dart';
import 'address_header.dart';
import 'bloc/address_bloc.dart';
import 'package:http/http.dart' as http;

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  static String route() => '/address';

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late String groupValue = '';
  bool doneLoading = false;

  @override
  void initState() {
    // if(Global.myAddress.value.isNotEmpty){
    //   groupValue = '';
    // }
    // context.read<AddressBloc>().add(GetAllAddress());
    callService();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: doneLoading == false ? const Center(child: CircularProgressIndicator(color: Colors.grey,)) : Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                  backgroundColor: ColorsConst.firstColor,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: AddressAppBar(),
                ),

              SliverPadding(
                // padding: padding,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver:
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) => _buildBody(context, Global.myAddress.value[index])),
                      childCount: Global.myAddress.value.length,
                    ),
                  )
              ),
              const SliverAppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: SizedBox(height: 24))
            ],
          ),
          if(Global.myCartItems.value.isNotEmpty)
          Padding(padding: const EdgeInsets.all(24), child: buildAddCard(),)
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, Address address) {
    return AddressIem(
      address: address, 
      groupValue: groupValue, 
      onChanged: (v){
        setState(() {
          groupValue = v;
        });
        ChoosePaymentScreenState.address = address;
        Navigator.pushNamed(context, ChoosePaymentScreen.route());
      });
  }

  buildAddCard() => Container(
    color: Colors.white,
    width: double.infinity,
    child: Container(
              height: 58,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(29)),
                color:  ColorsConst.firstColor,
                border: Border.all(color: Colors.black, width: 1),
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
                    //Navigator.pushNamed(context, AddAddressScreen.route());
                    Navigator.pushNamed(context, AddAddressScreen.route()).then((_) => setState((
                        ) {
                      doneLoading = false;
                      callService();
                    }));

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/profile/location@2x.png', scale: 2, color: ColorsConst.black,),
                      const SizedBox(width: 10),
                      const Text(
                        'Add another address',
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
  );

  void callService()async{
    log('id - ${LocalDB.getUserid()}');
    Post newPost = new Post(uid: LocalDB.getUserid());
    Post postRequest = await createPost('https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/newapi/new_addressList.php',
        body: newPost.toMap());
  }

  Future<Post> createPost(String url, {required Map body}) async {
    log('url - $url ');
    log('body - $body ');
    return http.post(Uri.parse(url), body: body).then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(response.statusCode);
        throw new Exception("Error while fetching data");
      }
      print(response.statusCode);
      var jsonList = jsonDecode(response.body);
      setState(() {
        if(jsonList["ResultData"] != null)
          {
            var addresses = (jsonList["ResultData"] as List).map((e) => Address.fromMap(e)).toList();
            Global.myAddress.value = addresses;
            AddressListed(addresses);
            Global.myAddress.notifyListeners();
          }
        else
          {
            Global.myAddress.value = [];
            Global.myAddress.notifyListeners();
            setState(() {

            });
          }
        doneLoading = true;
      });
      //print("Response:${response.body}")
      return Post.fromJson(json.decode(response.body));
    });
  }

}

class Post {
  final String uid;

  Post({required this.uid});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      uid: json['uid'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["uid"] = uid;
    return map;
  }
}