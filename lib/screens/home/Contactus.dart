import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';

import '../../resources/toast.dart';
import 'package:http/http.dart' as http;

class contactusScreen extends StatefulWidget {
  const contactusScreen({super.key});

  @override
  State<contactusScreen> createState() => _contactusScreenState();
}

class _contactusScreenState extends State<contactusScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobilenoController = TextEditingController();
  TextEditingController orderdetailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us',style: TextStyle(color: Colors.black),)
        ,
      ),
      body:Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          children: [
             TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey),),
                hintText: 'Name',
              ),
              controller: nameController,
            ),
            const SizedBox(height: 20,),
             TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey),),
                hintText: 'Phone Number',
              ),
              controller: mobilenoController,
            ),
            const SizedBox(height: 20,),
             TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey),),
                hintText: 'Order Details',
              ),
              controller: orderdetailController,
            ),
            const SizedBox(height: 30),
            Container(
              height: 50,

              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color:  ColorsConst.firstColor,
                border: Border.all(color: Colors.black, width: 1)
              ),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(29)),
                // splashColor: const Color(0xFFEEEEEE),
                onTap: () {
                  if(nameController.text == "")
                    {
                      toast('Please Enter Your Name', success: false);
                    }
                  else if(mobilenoController.text == "")
                    {
                      toast('Please Enter Your Phone Number', success: false);
                    }
                  else if(orderdetailController.text == "")
                  {
                    toast('Please Enter Your Order Details', success: false);
                  }
                  else
                    {
                      callService();
                    }

                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Submit',
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
          ],
        ),
      ),
    );
  }

  void callService()async{
    showLoaderDialog(context);
    Post newPost = new Post(name: nameController.text, mobile: mobilenoController.text,order_details:orderdetailController.text);
    Post postRequest = await createPost('https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/customenquiry.php',
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
      Navigator.of(context).pop();
      //var jsonList = jsonDecode(response.body);
      toast('Request Submitted our team will contact you shortly!', success: true);
      Navigator.of(context).pop();
      //print("Response:${response.body}")
      return Post.fromJson(json.decode(response.body));
    });
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=const AlertDialog(
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white,),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      useRootNavigator: false,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}

class Post {
  final String name;
  final String mobile;
  final String order_details;

  Post({required this.name,required this.mobile,required this.order_details});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      mobile: json['mobile'],
      order_details: json['order_details'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["mobile"] = mobile;
    map["order_details"] = order_details;
    return map;
  }
}