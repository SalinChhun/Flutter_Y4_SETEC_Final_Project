import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/model/Users/TokenModel.dart';
import 'package:ecommerce/repository/User/UserRepository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository = new UserRepository();
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      // TODO: implement event handler


      var email = event.email;
      var pass = event.password;
      print(email );
      print(pass);
      emit(LoginLoading());
      try{
      TokenModel responsebody = await userRepository.AuthUser(email , pass);
       // print(responsebody.access);
       // print(responsebody.refresh);

       if(responsebody.access == null ) {
         print("Unauthorize");
         emit(LoginUnAuthorize());

       }
       else{
         emit(LoginCompleted(token: responsebody ));
       }



       }catch(error) {
          emit(LoginError(error));
       }





    });
    on<LoginSocialAuth>((event, emit) async {
      // TODO: implement event handler
      print("Gmail has sent");


      var email = event.email;

      print(email );
      emit(LoginLoading());
      try{
        TokenModel responsebody = await userRepository.GoogleAuthUser(event.email);
        print(responsebody.access);
        print(responsebody.refresh);

        if(responsebody.access == null ) {
          print("Unauthorize");
          emit(LoginUnAuthorize());

        }
        else{
          emit(LoginCompleted(token: responsebody ));
        }



      }catch(error) {
        emit(LoginError(error));
      }





    });
  }
}
