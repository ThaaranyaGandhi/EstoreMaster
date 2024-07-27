

import '../../constants/apis_const.dart';
import '../api_client.dart';

class ProfileService {

  Future updateProfile()async{

    dynamic response = await ApiClient(ApisConst.profile).post(
      data: {
        'uid': "" , 
        'name': "",
        'email': "",
        'mobile': "", 
        'ccode': "", 
        'imei': "",
        'password': ""
      }
    );

    return response;
  }
}