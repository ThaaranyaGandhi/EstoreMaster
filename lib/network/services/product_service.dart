

import '../../constants/apis_const.dart';
import '../api_client.dart';

class ProductService {

  Future getProducts(String categoryId)async{
    var response = await ApiClient(ApisConst.product).post(
      data: {
        "cid": categoryId,
        "status": 1
      }
    );
    return response;
  }

}