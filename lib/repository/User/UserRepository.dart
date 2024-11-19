import 'package:ecommerce/data/network/networkservice.dart';
import 'package:ecommerce/model/Users/MessageRegister.dart';
import 'package:ecommerce/model/Users/TokenModel.dart';
import 'package:ecommerce/model/Users/UserResponse.dart';
import 'package:ecommerce/res/appurl/appurl.dart';

import '../../model/Users/UserModel.dart';

class UserRepository {


  NetworkApiService apiService = new NetworkApiService();
  Future<dynamic> ObtainToken(String? token) async {

    try{
      var res = await apiService.ObtainToken(token);
      print(res['access']);
      if(res['access']!=null) {
        print("data is not here ");
      }





      return res['access'];

      return res;



    }catch(e) {

      print(e);
      rethrow ;
    }
  }
  Future<dynamic> AuthUser(String? email ,String? password) async {

    try{
      var res = await apiService.AuthUser(email, password) as Map<String,dynamic>;
      print(res['data']);
      if(res['data']!=null) {
        print("data here ");
      }





      return TokenModel.fromJson(res);

      return res;



    }catch(e) {
      print(e);
     rethrow ;
    }
  }
  Future<dynamic> GoogleAuthUser(String? email ) async {

    try{
      var res = await apiService.LoginSocialAuthUser(email) as Map<String,dynamic>;
      print(res['data']);
      if(res['data']!=null) {
        print("data here ");
      }





      return TokenModel.fromJson(res);

      return res;



    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> AuthUserSignUp(fname,lname,String? email,String? password,telephone,username,gender) async {

    try{
      var res = await apiService.AuthSignUpUser(fname,lname,email, password,telephone,username,gender);
      print(res);
      if(res["error"].toString().contains("Email has already exist, try a new one")) {
            return res["error"];
      }
      return MessageRegister.fromJson(res);

      return res;



    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> SocialAuthRegister({String? email,String? password,username,telephone}) async {

    try{

      var res = await apiService.AuthRegisterGoogle(email,password,username,telephone);
      print(res);
      return MessageRegister.fromJson(res);

      return res;



    }catch(e) {
      print(e);
      rethrow ;
    }
  }


  Future<dynamic> FetchUser(uid) async {

    try{
      String? url = "${ApiUrl.usersingle}${uid}";
      var res = await apiService.FetchUser(url);






      return UserModel.fromJson(res);





    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> SendCode({email}) async {

    try{
      String? url = "${ApiUrl.resetsendcode}";
      var res = await apiService.SendCode(url, email);
      print(res.toString());

      return;


    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> SendMessage({title,userid}) async {

    try{
      String? url = "${ApiUrl.messagefeedback}";
      var res = await apiService.Postmessage(url, userid, title);
      print(res.toString());

      return;


    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> SendVerify({email,code}) async {

    try{
      String? url = "${ApiUrl.resetverify}";
      var res = await apiService.VerifyCode(url, email, code);
      print(res['message']);


      return res['message'];


    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  Future<dynamic> ResetPassword({email,pass }) async {

    try{
      String? url = "${ApiUrl.resetpw}";
      var res = await apiService.Changepassword(url, email, pass);

      return ;


    }catch(e) {
      print(e);
      rethrow ;
    }
  }
  // Future<dynamic> AuthVerify(String? email,String? password) async {
  //
  //   try{
  //     var res = await apiService.AuthSignUpUser(fname,lname,email, password,telephone,username);
  //
  //     return MessageRegister.fromJson(res);
  //
  //     return res;
  //
  //
  //
  //   }catch(e) {
  //     print(e);
  //     rethrow ;
  //   }
  // }
  Future<dynamic> UserEditing({fname,lname,telephone,username,gender,imgid,uid}) async {

    try{
      var url = "${ApiUrl.useredit}${uid}";
      print(url);

      print(imgid);
      var res;


        res = await apiService.UserEditing(fname, lname, telephone, username, gender,imgid,uid,url!);


      print(res);
      return UserResponse.fromJson(res);

      return res;



    }catch(e) {
      print(e);
      rethrow ;
    }
  }


}