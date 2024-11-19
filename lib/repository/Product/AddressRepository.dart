import 'package:ecommerce/data/network/networkservice.dart';
import 'package:ecommerce/model/Users/MessageRegister.dart';
import 'package:ecommerce/model/Users/TokenModel.dart';
import 'package:ecommerce/res/appurl/appurl.dart';
import 'package:ecommerce/viewmodel/products/address_bloc.dart';

import '../../model/Address.dart';
import '../../model/Address/AddressModel.dart';
import '../../model/Address/AddressRes.dart';
import '../../model/Address/AddressResDelete.dart';
import '../../model/Product/ProductModel.dart';

class AddressRepository {
  var url =ApiUrl.producturl;
  NetworkApiService apiService = new NetworkApiService();
  Future<dynamic> PostAddress(AddressBody? addressBody,userid,desc) async {

    try{

      var res = await apiService.AddressPost(ApiUrl.addressurlpost,addressBody! ,userid,desc);
      return AddressModelResponse.fromJson(res);




      // return TokenModel.fromJson(res);




    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> PutAddress(AddressBody? addressBody,userid,addid,desc) async {

    try{

      var res = await apiService.AddressPatch(ApiUrl.addressurlput,addressBody! ,userid,addid,desc);
      return AddressModelResponse.fromJson(res);




      // return TokenModel.fromJson(res);




    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> DeleteAddress(addid) async {

    try{

      var res = await apiService.DeleteAddress(addid);
      return AddDeleteResponse.fromJson(res);




      // return TokenModel.fromJson(res);




    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> FetchAddress(userid) async {

    try{

      var res = await apiService.AddressFetch(userid);
      return AddressModel.fromJson(res);





      // return TokenModel.fromJson(res);




    }catch(e) {
      print(e);
      rethrow ;
    }
  }


}