import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormStateAD> {
  FormBloc() : super(FormInitial()) {
    on<CheckValidateevent>((event, emit)async {
      // TODO: implement event handler
      var errorpass = event.iserrorpass;
      var erroremail = event.iserroremail;
      emit(FormLoading());

      await Future.delayed(Duration(
        seconds: 2
      ));
      if(errorpass == true ||erroremail == true ) {
        emit(FormError(true));
      }

      else {
        emit(FormValid());
      }

    });
  }
}
