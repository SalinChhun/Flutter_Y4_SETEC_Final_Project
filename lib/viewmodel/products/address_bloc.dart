import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/model/Address/AddressRes.dart';
import 'package:ecommerce/repository/Product/AddressRepository.dart';
import 'package:meta/meta.dart';

import '../../model/Address.dart';
import '../../model/Address/AddressModel.dart';
import '../../model/Address/AddressResDelete.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressRepository addressRepository = AddressRepository();
  AddressBloc() : super(AddressInitial()) {
    on<PostAddress>((event, emit) async {
      emit(AddressPostLoading());
      // TODO: implement event handler
      try{
        print("Send post adddress event");
        var response = await addressRepository.PostAddress(event.add, event.userid,event.desc);

        emit(AddressPostDone(addressModelResponse: response ));



      }catch(error) {
        print(error.toString());
        emit(AddressPostError());
      }

    });

    on<UpdateAddress>((event, emit) async {
      emit(AddressPostLoading());
      // TODO: implement event handler
      try{
        print("Send post adddress event");
        var response = await addressRepository.PutAddress(event.add, event.userid,event.addressid,event.desc);

        emit(AddressPostDone(addressModelResponse: response));



      }catch(error) {
        print(error.toString());
        emit(AddressPostError());
      }

    });
    on<FetchAddress>((event, emit) async {
      emit(AddressLoading());
      // TODO: implement event handler
      try{
        print("Send post event");
        var response = await addressRepository.FetchAddress(event.userid);
        print(response);
        emit(AddressDone(add:response ));


      }catch(error) {
        print(error.toString());
        emit(AddressError());
      }

    });
    on<DeleteAddress>((event, emit) async {
      emit(AddressPostLoading());
      // TODO: implement event handler
      try{
        print("Send post adddress event");
        var response = await addressRepository.DeleteAddress(event.id);

        emit(AddressPostDone(addDeleteResponse:response  ));



      }catch(error) {
        print(error.toString());
        emit(AddressPostError());
      }

    });
  }
}
class AddressBlocV2 extends Bloc<AddressEvent, AddressState> {
  AddressRepository addressRepository = AddressRepository();
  AddressBlocV2() : super(AddressInitial()) {
    on<PostAddress>((event, emit) async {
      emit(AddressLoading());
      // TODO: implement event handler
      try{
        print("Send post adddress event");
        var response = await addressRepository.PostAddress(event.add, event.userid,event.desc);

        emit(AddressDone( ));



      }catch(error) {
        print(error.toString());
        emit(AddressError());
      }

    });


    on<FetchAddress>((event, emit) async {
      emit(AddressLoading());
      // TODO: implement event handler
      try{
        print("Send post event");
        var response = await addressRepository.FetchAddress(event.userid);
        print(response);
        emit(AddressDone(add:response ));


      }catch(error) {
        print(error.toString());
        emit(AddressError());
      }

    });
  }
}