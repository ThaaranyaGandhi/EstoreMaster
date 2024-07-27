


import 'package:fresh_store_ui/screens/auth/bloc/auth_bloc.dart';

import '../../constants/apis_const.dart';
import '../api_client.dart';

class AuthService {

  Future register(String email, String password, String name, String mobileNumber)async{
    
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    dynamic response = await ApiClient("${ApisConst.register}?name='test'&mobile='123454'&imei=asdh&password='123456'&ccode=1&email='test@gmail.com'")
        .post();
    return response;
  }

  Future login(String email, String password)async{

    dynamic response = await ApiClient(ApisConst.login).post(
      data: {
        "email": email,
        "password": password
      }
    );

    return response;
  }

  Future orderhis(String uid, String orderid)async{

    dynamic response = await ApiClient(ApisConst.login).post(
        data: {
          "uid": uid,
          "orderid": orderid
        }
    );

    return response;
  }

}