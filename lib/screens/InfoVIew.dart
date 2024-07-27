import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../constants/assets_const.dart';
import '../db/local_db.dart';
import 'Orderinfo_model.dart';
import 'package:http/http.dart' as http;

import 'Orderinfo_model.dart';
import 'auth/bloc/auth_bloc.dart';

class InfoviewScreen extends StatefulWidget {
  String? orderid;
  InfoviewScreen(this.orderid);
  static String route() => '/infoview';
  @override
  State<StatefulWidget> createState() {
    return InfoviewState(this.orderid);
  }
}

class InfoviewState extends State<InfoviewScreen> {
  bool doneLoading = false;
  late Orderinfo_model Orderinfo;
  String? orderid;
  InfoviewState(this.orderid);
  @override
  void initState() {
    doneLoading = false;
    super.initState();
    var orderid;
   Future.delayed(Duration.zero, () {
     callService();
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placed Order',style: TextStyle(color: Colors.black),),centerTitle: true
        ,
      ),
      body: doneLoading == false ? Center(child: CircularProgressIndicator(color: Colors.grey,)) :Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),child: Card(
              child: ListView.builder(

                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Orderinfo.productinfo?.length,
                  itemBuilder: (context, index) {
                   var price = double.parse(Orderinfo.productinfo![index].productQty.toString()) * double.parse(Orderinfo.productinfo![index].productPrice.toString());
                   print(price);
                    return  Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5,right: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  flex:3,
                                  child: SizedBox(width: 100,height: 100,child: Image.network('https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/${Orderinfo.productinfo![index].productImage.toString()}',fit: BoxFit.cover,),),),
                              SizedBox(width: 5,),
                              Expanded(
                                  flex:5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(' ${Orderinfo.productinfo![index].productName.toString()}',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600),),
                                      SizedBox(height: 5,),
                                      Text('Qty - ${Orderinfo.productinfo![index].productQty.toString()} x ${Orderinfo.productinfo![index].productPrice.toString()}',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600)),
                                      //Text('Discount \$ ${Orderinfo.productinfo![index].discount.toString()}',style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600))
                                    ],
                                  )),
                              SizedBox(width: 5,),
                              Expanded(
                                  flex:2,
                                  child: Text('\$ ${price}',style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.w600,),))
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],

                    );
                  }),
            ),),
      Padding(padding: EdgeInsets.only(left: 30,right: 30,top: 10),child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text('Total',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.blue),textAlign: TextAlign.left,)),
          Expanded(child: Text('\$ ${Orderinfo.totalAmt.toString()}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.blue),textAlign: TextAlign.right,)),
        ],),),

          ],
        ),
      ),
    );
  }

  void callService()async{
    Post newPost = new Post(uid: LocalDB.getUserid(), id: orderid.toString());
    Post postRequest = await createPost('https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/orderinfo.php',
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
      print("sss" + response.body);
      var jsonList = jsonDecode(response.body);
      Orderinfo = Orderinfo_modelModelFromJson(response.body);
      print(Orderinfo.productinfo?[0].productName);
      doneLoading = true;
      setState(() {

      });
      //print("Response:${response.body}")
      return Post.fromJson(json.decode(response.body));
    });
  }
}

class Post {
  final String uid;
  final String id;

  Post({required this.uid,required this.id});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      uid: json['uid'],
      id: json['id'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["uid"] = uid;
    map["id"] = id;
    return map;
  }
}