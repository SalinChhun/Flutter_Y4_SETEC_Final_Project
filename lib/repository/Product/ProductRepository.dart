import 'package:ecommerce/data/network/networkservice.dart';
import 'package:ecommerce/model/Product/ProductFavModel.dart';
import 'package:ecommerce/model/Product/SuperDealById.dart';
import 'package:ecommerce/model/Product/SuperdealModel.dart';
import 'package:ecommerce/model/Users/MessageRegister.dart';
import 'package:ecommerce/model/Users/TokenModel.dart';
import 'package:ecommerce/res/appurl/appurl.dart';

import '../../model/Product/ProductModel.dart';

class ProductRepository {
  var url =ApiUrl.producturl;
  NetworkApiService apiService = new NetworkApiService();
  Future<dynamic> FetchSuperDeal({page}) async {

    try{



      print(page);
      var res = await apiService.FetchSuperDeal(page: page);
      return SuperDealModel.fromJson(res);


    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> FetchSuperSingle(id) async {

    try{


      var res = await apiService.FetchSuperDealSingle(id: id);
      return SuperDealSingle.fromJson(res);


    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> FetchProduct({page}) async {

    try{



        print("New Arrival");
        print(page);
        var res = await apiService.GetAllproduct(ApiUrl.producturl,"",page: page);
        return ProductModel.fromJson(res);


    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> ProductFavoriteById(uid,pid) async {

    try{



      var res = await apiService.FetchFavoriteById(uid, pid);
      return ProductFavModel.fromJson(res);


    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> FavFetchProduct(uid) async {

    try{



      var res = await apiService.FetchFavorite(uid);
      return ProductFavModel.fromJson(res);


    }catch(e) {
      print(e);
      rethrow ;
    }
  }



  Future<dynamic> RemoveFavorite (pid,uid) async
  {

    try{



      var res = await apiService.RemoveFavorite(pid, uid);
      return ;


    }catch(e) {
      print(e);
      rethrow ;
    }
  }





  Future<dynamic> SortProduct(sort,rank,{search,page}) async {

    try{


      var res;

      print(ApiUrl.producturl);
      print(sort);
      print(rank);
      print(search);
      print(page);

       res = await apiService.Sortproduct(ApiUrl.producturl,sort,rank ,search: search ,page: page);

      // print(res);

      return ProductModel.fromJson(res);





      // return TokenModel.fromJson(res);




    }catch(e) {
      print(e);
      rethrow ;
    }
  }

  Future<dynamic> QueryProduct(search,{page}) async {

    try{


      print("Query Product In Repository");
      var res = await apiService.Searchproduct(ApiUrl.producturl,search,page: page);
      return ProductModel.fromJson(res);





      // return TokenModel.fromJson(res);




    }catch(e) {
      print(e);
      rethrow ;
    }
  }


  Future<dynamic> QueryProductFilter(search,{cid,maxprice,minprice,sort,rank}) async {

    try{


      print("Filter Product In Repository");
      var res = await apiService.FilterProduct(ApiUrl.producturl,search,

          cid: cid,

      maxprice: maxprice,
        minprice: minprice,
        sort: sort,
        rank: rank

      );
      return ProductModel.fromJson(res);





      // return TokenModel.fromJson(res);




    }catch(e) {
      print(e);
      rethrow ;
    }
  }

  Future<dynamic> FetchProductDiscount() async {

    try{

        print("discount");
        var res = await apiService.GetAllproduct(ApiUrl.producturlsuperdeal,"");
        return ProductModel.fromJson(res);







      // return TokenModel.fromJson(res);




    }catch(e) {
      print(e);
      rethrow ;
    }
  }


}