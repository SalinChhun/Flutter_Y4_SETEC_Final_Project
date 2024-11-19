part of 'address_bloc.dart';


abstract class AddressEvent {


}
class DeleteAddress extends AddressEvent {
  var id;
  DeleteAddress({this.id});
}
class FetchAddress extends AddressEvent {
  var userid;

  FetchAddress({this.userid});
}
class PostAddress extends AddressEvent {
  AddressBody? add;
  var userid;
  var addressid;
var desc;
PostAddress({this.add,this.userid,this.addressid,this.desc});
}

class UpdateAddress extends AddressEvent {
  AddressBody? add;
  var userid;
  var addressid;
  var desc;
  UpdateAddress({this.add,this.userid,this.addressid,this.desc});
}
