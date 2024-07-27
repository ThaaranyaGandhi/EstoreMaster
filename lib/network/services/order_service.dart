

import 'package:fresh_store_ui/db/local_db.dart';
import 'package:fresh_store_ui/global.dart';
import 'package:fresh_store_ui/network/models/order_product.dart';

import '../../constants/apis_const.dart';
import '../api_client.dart';

class OrderService {

  Future createOrder({
    required String ddate,
    required String addressId,
    required double total,
    required List<OrderProduct> products,
    required ordertype
  })async{

    dynamic response = await ApiClient(ApisConst.order).post(
      data: {
        'uid': LocalDB.getUserid(), 
        'ddate': ddate,
        'timesloat': "${Global.timeSlot!.mintime} - ${Global.timeSlot!.maxtime}",
        'p_method': ordertype,
        'address_id': addressId,
        'coupon_id': 0,
        'cou_amt': 0,
        'usedwal': "0",
        'tax': "0",
        'tid': "0",
        'total': total,
        "pname": products.map((e) => e.toMap()).toList()
      }
    );

    print(response);

    return response;
  }

  Future cancelOrder(String uid, String oid)async{

    dynamic response = await ApiClient(ApisConst.orderCancel).post(
      data: {
        "uid": uid,
        "oid": oid
      }
    );

    return response;
  }

  Future orderHistory(String uid)async{

    dynamic response = await ApiClient(ApisConst.history).post(
      data: {
        "uid": uid
      }
    );

    return response;
  }

}