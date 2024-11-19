import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/model/Users/UserResponse.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../model/Users/UserModel.dart';
import '../../repository/User/UserRepository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository = UserRepository();
  UserBloc() : super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      // TODO: implement event handler
      emit(LoadingUser());
      try {
      var res = await userRepository.FetchUser(event.userid!);
      print(res);
      emit(LoadingUserDone(user: res));
      }
      catch(error) {
          emit(LoadingUserError(error: error.toString()));
      }
    });
    on<EditUser>((event, emit) async {
      // TODO: implement event handler
      print("Event Edi "+event.imgid);
        var idimg ;

      emit(UserPatchLoading());
      try {
        var res = await userRepository.UserEditing(
          imgid: event.imgid,
          telephone: event.telephone,
          gender: event.gender,
          username: event.username,
          fname: event.fname,
          lname: event.lastname,
          uid: event.userid

        );
        print(res);
        try{
          emit(LoadingUser());
          var response = await userRepository.FetchUser(event.userid!);
          print(response);
          emit(LoadingUserDone(user: response));
        }catch(error) {
          emit(LoadingUserError(error: error.toString()));
        }


      }
      catch(error) {
        emit(UserPatchError());
      }
    });
    on<SendMessage>((event, emit) async {
      // TODO: implement event handler
      var idimg ;

      emit(UserMessageLoading());
      try {
        var res = await userRepository.SendMessage(title: event.message,userid: event.userid);
        print(res);
        try{
          var response = await userRepository.FetchUser(event.userid!);
          print(response);
          emit(UserMessageCompleted());
        }catch(error) {
          emit(UserMessageError());
        }


      }
      catch(error) {
        emit(UserPatchError());
      }
    });
  }
}
