

import 'package:dio/dio.dart';
import 'package:fresh_store_ui/db/local_db.dart';
import 'package:fresh_store_ui/global.dart';
import 'package:fresh_store_ui/network/models/address.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/apis_const.dart';
import '../api_client.dart';

class AddressService {

  Future addAddress({
    required String hno,
    required String society,
    required String pincode,
    required String area,
    required String landmark,
    required String type,
    required String name
  })async{

    dynamic response = await Dio().post("https://rockfortgrocery.com/rockfortgroceryAdmin/admin_panel/api/new_address.php?uid=${LocalDB.getUserid()}&hno=${hno.replaceAll(' ', '%20')}&society=${society.replaceAll(' ', '%20')}&area=${area.replaceAll(' ', '%20')}&pincode=${pincode.replaceAll(' ', '%20')}&landmark=${landmark.replaceAll(' ', '%20')}&type=${type.replaceAll(' ', '%20')}&name=${name.replaceAll(' ', '%20')}");

    var addressResponse= await ApiClient(ApisConst.addressList).post(
      data: {"uid": LocalDB.getUserid()}
    );
    var addresses = (addressResponse["ResultData"] as List).map((e) => Address.fromMap(e)).toList();
    Global.myAddress.value = addresses;
    print(response);
    return response;
  }

  Future updateAddress(Address address)async{

    dynamic response = await ApiClient(ApisConst.address).post(
      data: address.toMap()
    );

    return response;
  }

  Future getAllAddress()async{

    print(LocalDB.getUserid());

    dynamic response = await ApiClient(ApisConst.addressList).post(
      data: {"uid": LocalDB.getUserid()}
    );
    print(response);
    return response;
  }
}