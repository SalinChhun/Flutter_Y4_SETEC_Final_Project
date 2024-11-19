import 'package:ecommerce/data/network/networkservice.dart';
import 'package:ecommerce/model/Category/ProductCategory.dart';
import 'package:ecommerce/model/Users/MessageRegister.dart';
import 'package:ecommerce/model/Users/TokenModel.dart';
import 'package:ecommerce/res/appurl/appurl.dart';
import 'package:ecommerce/viewmodel/category/category_bloc.dart';

import '../../model/Category/CategoryModel.dart';
import '../../model/Image/ImageResponse.dart';
import '../../model/Product/ProductModel.dart';

class ImageRepository {
  var url = ApiUrl.imagepost;
  NetworkApiService apiService = new NetworkApiService();

  Future<dynamic> UploadImage({imagepath}) async {
    try {
      var res = await apiService.UploadImage(url,imagepath: imagepath);
      return Imageresponse.fromJson(res);


      // return TokenModel.fromJson(res);


    } catch (e) {
      print(e);
      rethrow;
    }
  }

}
