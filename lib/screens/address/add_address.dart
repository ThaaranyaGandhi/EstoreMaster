import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_store_ui/constants/colors_const.dart';
import 'package:fresh_store_ui/network/models/address.dart';
import 'package:fresh_store_ui/resources/toast.dart';
import 'package:fresh_store_ui/screens/address/add_address_header.dart';
import 'package:fresh_store_ui/screens/address/bloc/address_bloc.dart';

import '../../db/local_db.dart';
import '../../global.dart';
import '../../network/services/address_service.dart';
import '../widgets/input_field.dart';
import 'package:http/http.dart' as http;

class AddAddressScreen extends StatefulWidget {
  final Address? address;
  const AddAddressScreen({super.key, this.address});

  static String route() => '/add-address';

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController noController = TextEditingController();
  TextEditingController societyController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  var aid;

  GlobalKey<FormState> formKey = GlobalKey();
  var service = AddressService();
  @override
  void didChangeDependencies() {
    Address? address = ModalRoute.of(context)?.settings.arguments as Address?;

    if (address != null) {
      aid = address.aid;
      nameController.text = address.name;
      typeController.text = address.type;
      noController.text = address.no;
      societyController.text = address.society;
      areaController.text = address.area;
      landmarkController.text = address.landmark;
      pincodeController.text = address.pincode;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.fromLTRB(24, 24, 24, 0);
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddressCreated) {
          toast('Address added successfully', success: true);
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pop(context);
          });
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              backgroundColor: ColorsConst.firstColor,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: AddAddressAppBar(),
            ),
            SliverPadding(
              padding: padding,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  ((context, index) => _buildBody(context)),
                  childCount: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          InputField(
            controller: nameController,
            hintText: 'Name',
          ),
          const SizedBox(
            height: 24,
          ),
          InputField(
            controller: typeController,
            hintText: 'Address Type',
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: InputField(
                  controller: noController,
                  hintText: 'Home No',
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                flex: 6,
                child: InputField(
                  controller: societyController,
                  hintText: 'Society',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          InputField(
            controller: areaController,
            hintText: 'Area',
          ),
          const SizedBox(
            height: 24,
          ),
          InputField(
            controller: landmarkController,
            hintText: 'Landmark',
          ),
          const SizedBox(
            height: 24,
          ),
          InputField(
            controller: pincodeController,
            hintText: 'Pincode',
          ),
          const SizedBox(
            height: 54,
          ),
          buildAddCard(),
        ],
      ),
    );
  }

  buildAddCard() => Container(
        height: 58,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          color: ColorsConst.firstColor,
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
              if (!formKey.currentState!.validate()) {
                return;
              }

              if (aid != null) {
                // context.read<AddressBloc>().add(UpdateAddress(
                //   address: Address(
                //     aid: aid,
                //     no: noController.text,
                //     society: societyController.text,
                //     pincode: pincodeController.text,
                //     area: areaController.text,
                //     landmark: landmarkController.text,
                //     type: typeController.text,
                //     name: nameController.text)));
                callupdateService();
              } else {
                // context.read<AddressBloc>().add(AddAddress(
                //   hno: noController.text,
                //   society: societyController.text,
                //   pincode: pincodeController.text,
                //   area: areaController.text,
                //   landmark: landmarkController.text,
                //   type: typeController.text,
                //   name: nameController.text));
                print('add');
                calladdService();
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void callupdateService() async {
    showLoaderDialog(context);
    UpdatePost newPost = new UpdatePost(
        uid: LocalDB.getUserid(),
        aid: aid,
        no: noController.text,
        society: societyController.text,
        pincode: pincodeController.text,
        area: areaController.text,
        landmark: landmarkController.text,
        type: typeController.text,
        name: nameController.text);
    log('new update - $newPost');
    UpdatePost postRequest = await UpdatePost1(
        'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/newapi/new_address.php',
        body: newPost.toMap());
  }

  Future<UpdatePost> UpdatePost1(String url, {required Map body}) async {
    return http
        .post(Uri.parse(url), body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(response.statusCode);
        throw new Exception("Error while fetching data");
      }
      Navigator.pop(context);
      print(response.statusCode);
      var jsonList = jsonDecode(response.body);
      if (jsonList["ResponseCode"] == "200") {
        toast('Address updated successfully', success: true);
        Navigator.pop(context);
      } else {
        toast('Address Failed to update', success: false);
      }
      return UpdatePost.fromJson(json.decode(response.body));
    });
  }

  void calladdService() async {
    showLoaderDialog(context);
    addaddress newPost = new addaddress(
        uid: LocalDB.getUserid(),
        hno: noController.text,
        society: societyController.text,
        pincode: pincodeController.text,
        area: areaController.text,
        landmark: landmarkController.text,
        type: typeController.text,
        name: nameController.text);
    log('newPost - ${newPost.toMap()}');
    // createAddress(body: newPost.toMap());
    addaddress postRequest = await createPost1(
        'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/newapi/new_address.php',
        body: newPost.toMap());
  }

  Future<void> createAddress({required Map body}) async {
    final _client = http.Client();
    var url = Uri.parse(
        'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/newapi/new_address.php');
    var response = await _client.post(url, body: body);
    log('status code - ${response.statusCode}');
    if (response.statusCode == 200) {
      var responseBody = response.body;
      log('response body - $responseBody');
      log('response json - ${json.decode(responseBody)}');
    }
  }

  Future<addaddress> createPost1(String url, {required Map body}) async {
    log('url - $url');
    return http
        .post(Uri.parse(url), body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        log(response.statusCode.toString());
        log('Exception - ${response}');
        throw new Exception("Error while fetching data");
      }
      Navigator.pop(context);
      print(response.statusCode);
      log('jsonList - ${jsonDecode(response.body)}');
      var jsonList = json.decode(response.body);
      log('jsonList - $jsonList');
      if (jsonList["ResponseCode"] == "200") {
        toast('Address added successfully', success: true);
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
      } else {
        toast('Address added Failed', success: false);
      }
      print("Response:${response.body}");
      return addaddress.fromJson(json.decode(response.body));
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = const AlertDialog(
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class UpdatePost {
  final String uid;
  final String aid;
  final String no;
  final String society;
  final String pincode;
  final String area;
  final String landmark;
  final String type;
  final String name;

  UpdatePost(
      {required this.uid,
      required this.aid,
      required this.no,
      required this.society,
      required this.pincode,
      required this.area,
      required this.landmark,
      required this.type,
      required this.name});

  factory UpdatePost.fromJson(Map<String, dynamic> json) {
    return UpdatePost(
      uid: json['uid'],
      aid: json['aid'],
      no: json['no'],
      society: json['society'],
      pincode: json['pincode'],
      area: json['area'],
      landmark: json['landmark'],
      type: json['type'],
      name: json['name'],
    );
  }

  Map toMap() {
    var map = new Map<String, String>();
    map["uid"] = uid;
    map["aid"] = aid;
    map["no"] = no;
    map["society"] = society;
    map["pincode"] = pincode;
    map["area"] = area;
    map["landmark"] = landmark;
    map["type"] = type;
    map["name"] = name;

    print(
        "Parameter:::${'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/address.php'}${map.toString()}");
    return map;
  }
}

class addaddress {
  final String uid;
  final String hno;
  final String society;
  final String pincode;
  final String area;
  final String landmark;
  final String type;
  final String name;

  addaddress(
      {required this.uid,
      required this.hno,
      required this.society,
      required this.pincode,
      required this.area,
      required this.landmark,
      required this.type,
      required this.name});

  factory addaddress.fromJson(Map<String, dynamic> json) {
    return addaddress(
      uid: json['uid'],
      hno: json['hno'],
      society: json['society'],
      pincode: json['pincode'],
      area: json['area'],
      landmark: json['landmark'],
      type: json['type'],
      name: json['name'],
    );
  }

  Map toMap() {
    var map = new Map<String, String>();
    map["uid"] = uid;
    map["hno"] = hno;
    map["society"] = society;
    map["pincode"] = pincode;
    map["area"] = area;
    map["landmark"] = landmark;
    map["type"] = type;
    map["name"] = name;

    print(
        "Parameter:::${'https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/newapi/new_address.php'}${map.toString()}");
    return map;
  }
}
