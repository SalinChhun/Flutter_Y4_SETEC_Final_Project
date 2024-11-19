import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/User/UserRepository.dart';

part 'reset_event.dart';
part 'reset_state.dart';

class ResetBloc extends Bloc<ResetEvent, ResetState> {

  UserRepository userRepository = UserRepository();
  ResetBloc() : super(ResetInitial()) {
    on<SendCode>((event, emit) async {
      // TODO: implement event handler

      try{
        emit(ResetVerifyCodeLoading());
        var res = await userRepository.SendCode(email: event.email);
        emit(ResetVerifyCodeSuccess());
      }catch(error) {
        emit(ResetVerifyCodeError());
      }
    });
    on<ResendVerifyCode>((event, emit) async {
      // TODO: implement event handler
      try{
        emit(ResetVerifyCodeLoading());
        var res = await userRepository.SendCode(email: event.email);
        emit(ResendCodeSuccess());
      }catch(error) {
        emit(ResetVerifyCodeError());
      }
    });



    on<SendVerifyCode>((event, emit) async {
      // TODO: implement event handler

      try{
        emit(VerifyCodeLoading());
        var res = await userRepository.SendVerify(email: event.email,code: event.code);
        if(res.toString().contains("wrong code please try again")) {
          emit(UnAuthorizeCode());
        }
        if(res.toString().contains("Verified")) {
          emit(VerifyCodeAuthorize());
        }


      }catch(error) {
        print(error.toString());
        emit(VerifyCodeError());
      }
    });
    on<SendResetPassword>((event, emit) async {
      // TODO: implement event handler

      try{
        emit(ResetPasswordLoading());
        var res = await userRepository.ResetPassword(email: event.email,pass:event.password);
        emit(ResetPasswordSccess());
      }catch(error) {
        emit(ResetPasswordError());
      }
    });
  }
}
