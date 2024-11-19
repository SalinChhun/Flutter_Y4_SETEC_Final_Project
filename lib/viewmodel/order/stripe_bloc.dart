import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'stripe_event.dart';
part 'stripe_state.dart';

class StripeBloc extends Bloc<StripeEvent, StripeState> {
  StripeBloc() : super(StripeInitial()) {
    on<StripePayMent>((event, emit) {
      // TODO: implement event handler
      emit(StripeLoading());



    });
  }
}
