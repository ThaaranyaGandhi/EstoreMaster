import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/screens/address/myaddress_item.dart';

import '../../constants/colors_const.dart';
import '../../db/local_db.dart';
import '../../global.dart';
import '../../network/models/address.dart';
import 'add_address.dart';
import 'bloc/address_bloc.dart';
import 'header.dart';
import 'package:http/http.dart' as http;

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  static String route() => '/myAddress';

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: doneLoading == false ? const Center(child: CircularProgressIndicator(color: Colors.grey,)) :  Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: <Widget>[
              const SliverPadding(
                padding: EdgeInsets.only(top: 24),
                sliver: SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: MyAddressAppBar(),
                ),
              ),
              SliverPadding(
                  // padding: padding,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      if(state is AddressListed){
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            ((context, index) => _buildBody(
                                context, Global.myAddress.value[index])),
                            childCount: Global.myAddress.value.length,
                          ),
                        );
                      }else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            ((context, index) => const SizedBox.shrink()),
                            childCount: 1,
                          )
                        );
                      }
                    },
                  )),
              const SliverAppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: SizedBox(height: 24))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: buildAddCard(),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, Address address) {
    return MyAddressIem(address: address);
  }

  buildAddCard() => Container(
      color: Colors.white,
      width: double.infinity,
      child: Container(
        height: 58,
        width: 200,
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
            // splashColor: const Color(0xFFEEEEEE),
            onTap: () {
              Navigator.pushNamed(context, AddAddressScreen.route());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/profile/location@2x.png',
                  scale: 2,
                  color: ColorsConst.white,
                ),
                const SizedBox(width: 16),
                const Text(
                  'Add another address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ));

  void callService()async{
    Post newPost = new Post(uid: LocalDB.getUserid());
    Post postRequest = await createPost('https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/new_addressList.php',
        body: newPost.toMap());
  }

  Future<Post> createPost(String url, {required Map body}) async {
    return http.post(Uri.parse(url), body: body).then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(response.statusCode);
        throw new Exception("Error while fetching data");
      }
      print(response.statusCode);
      print("sss" + LocalDB.getUserid());
      print("sss" + response.body);
      var jsonList = jsonDecode(response.body);
      setState(() {
        print('cscdsds');
        print(jsonList["ResultData"]);
        if(jsonList["ResultData"] != null)
        {
          var addresses = (jsonList["ResultData"] as List).map((e) => Address.fromMap(e)).toList();
          Global.myAddress.value = addresses;
          print('fscdsc${Global.myAddress.value}');
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