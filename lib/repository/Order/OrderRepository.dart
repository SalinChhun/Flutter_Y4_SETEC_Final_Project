import 'package:ecommerce/data/network/networkservice.dart';
import 'package:ecommerce/model/Order/OrderDetail.dart';
import 'package:ecommerce/model/Order/OrderRequest.dart';
import 'package:ecommerce/model/Order/OrderResponse.dart';
import 'package:ecommerce/model/Order/OrderUser.dart';
import 'package:ecommerce/model/Users/MessageRegister.dart';
import 'package:ecommerce/model/Users/TokenModel.dart';
import 'package:ecommerce/res/appurl/appurl.dart';

import '../../model/Category/CategoryModel.dart';
import '../../model/Product/ProductModel.dart';

class OrderRepository {
  var url = ApiUrl.producturl;
  NetworkApiService apiService = new NetworkApiService();

  Future<dynamic> PostOrderUser( addressid,OrderRequestV2? orderRequestV2) async {
    try {
      var res = await apiService.PostOrder(ApiUrl.orderurl,addressid,orderRequestV2);
      print("Repostiory Post Order User");
      // print(res);

      return OrderReponse.fromJson(res);
      // return CartegoryModel.fromJson(res);


      // return TokenModel.fromJson(res);


    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<dynamic> GetOrderSummary( orderid) async {
    try {
      var res = await apiService.GetOrderSummary(ApiUrl.ordergetorder,orderid);
      print(res);

      return OrderList.fromJson(res);
      // return CartegoryModel.fromJson(res);


      // return TokenModel.fromJson(res);


    } catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<dynamic> GetOrderUser( userid) async {
    try {
      var res = await apiService.GetOrderUser(ApiUrl.orderuserurl,userid);
      return OrderListUser.fromJson(res);
      // return CartegoryModel.fromJson(res);


      // return TokenModel.fromJson(res);


    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
