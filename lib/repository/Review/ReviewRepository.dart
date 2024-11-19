import 'package:ecommerce/data/network/networkservice.dart';
import 'package:ecommerce/model/Users/MessageRegister.dart';
import 'package:ecommerce/model/Users/TokenModel.dart';
import 'package:ecommerce/res/appurl/appurl.dart';

import '../../model/Address.dart';
import '../../model/Address/AddressModel.dart';
import '../../model/Address/AddressRes.dart';
import '../../model/Product/ProductModel.dart';
import '../../model/Review/ResponseReview.dart';
import '../../model/Review/ReviewModel.dart';


class ReviewRepository {
  var url =ApiUrl.reviewurl;
  NetworkApiService apiService = new NetworkApiService();

  Future<dynamic> FetchReviewUser(pid) async {
     print(url);
    try{
      url = ApiUrl.reviewpro;

      var res = await apiService.GetReviewUser(url, pid);
        print(res);
      return ReviewModel.fromJson(res);


    }catch(e) {
      print(e);
      rethrow ;
    }
  }

  Future<dynamic> PostReviewUser(pid,userid,desc,rating) async {
    print(url);
    var res;
    try{
      url = ApiUrl.reviewurl;

       res = await apiService.PostReviewUser(url, userid, desc, rating, pid);
       // print(res['message']);
      //
      // if(res['message'] != null) {
      //   print("true");
      //   return res;
      // }
      // else {
      //   print("get Response back");
      //   return ResponseReview.fromJson(res);
      // }
      // print("Review response: ${res }");
      print("Review Repository ${res}");


      return ResponseReview.fromJson(res);


    }catch(e) {
      print("Error at review repository");
      print(e.toString());


      rethrow ;
    }
  }
}