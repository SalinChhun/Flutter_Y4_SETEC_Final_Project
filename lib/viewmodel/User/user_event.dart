part of 'user_bloc.dart';


abstract class UserEvent {

}
class FetchUser extends UserEvent {
  var userid;

  FetchUser(this.userid);
}
class SendMessage extends UserEvent {
  var message;
  var userid;

  SendMessage(this.message,this.userid);
}
class EditUser extends UserEvent {
  var userid;
  var username;
  var lastname;
  var fname;
  var telephone;
  var gender;
  var imgid;




  EditUser({
    this.userid,
    this.username,
    this.lastname,
    this.fname,
    this.telephone,
    this.gender,
    this.imgid,

});
}

