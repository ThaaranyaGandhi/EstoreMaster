

import 'package:fresh_store_ui/db/local_db.dart';

import '../../constants/apis_const.dart';
import '../api_client.dart';

class CommonService {
  
  Future getBanners()async{
    var response = await ApiClient(ApisConst.banner).gets();
    return response;
  }

  Future getCategories()async{
    var response = await ApiClient(ApisConst.category).gets();
    return response;
  }

  Future getMain()async{
    var response = await ApiClient(ApisConst.main).post(data: {"uid" : LocalDB.getUserid()??"1"});
    return response;
  }

  Future search(String keyword)async{
    var response = await ApiClient(ApisConst.search).post(data: {"keyword" : keyword});
    return response;
  }

  Future getTimeslot()async{
    var response = await ApiClient(ApisConst.timeslot).gets();
    return response;
  }



}