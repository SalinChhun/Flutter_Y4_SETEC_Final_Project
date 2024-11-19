import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/Users/TokenModel.dart';
import '../../repository/User/UserRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  Future<String? > setPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Starting");
    print(prefs?.getBool("islogin"));
    print("User id: ${ prefs!.getInt("userid")}");
    prefs!.getString('token');
    print(prefs!.getString('token'));
    return   prefs?.getString('token');
    // prefs!.remove("token");
    // prefs!.remove("userid");
  }
  UserRepository userRepository = UserRepository();
  TokenBloc() : super(TokenInitial()) {
    // on<SendTokenAuthorize>((event, emit) async  {
    //   // TODO: implement event handler
    //   var email = event.email;
    //   var pass = event.pass;
    //   try{
    //     emit(TokenLoading());
    //     TokenModel responsebody = await userRepository.AuthUser(email , pass);
    //     print(responsebody.access);
    //     print(responsebody.refresh);
    //     if(responsebody.access == null ) {
    //       print("Unauthorize");
    //       emit(TokenUnauthorize() );
    //
    //     }
    //     else{
    //       // emit(TokenVerify(responsebody));
    //     }
    //   }catch(err){
    //     emit(TokenError());
    //   }
    // });
    on<VerifyTokenUser>((event, emit) async  {
      // TODO: implement event handler

      try{
        var res = await setPreference();
        print(res.toString());
        if(res ==null || res =='') {
            emit(TokenUnauthorize());
        }
        else{
          emit(TokenVerify());
        }
      }catch(err) {
        print(err.toString());
          emit(TokenError());
      }
        var token = await setPreference();


    });
    on<RefreshToken>((event, emit) async  {
      // TODO: implement event handler

      try{
        emit(TokenLoading());
        var res = await userRepository.ObtainToken(event.refreshtoken);
        print(res.toString());
        if(res ==null || res =='') {
          emit(TokenUnauthorize());
        }
        else{
          emit(TokenVerify());
        }
      }catch(err) {
        print(err.toString());
        if(err.toString().contains("No Internet")) {
          emit(TokenNoInternet());
        }
        else{
          emit(TokenError());
        }

      }



    });
  }



}
