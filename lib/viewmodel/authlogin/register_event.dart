part of 'register_bloc.dart';


abstract class RegisterEvent {}

class OnVerify extends RegisterEvent {
  var email;
  var password;

  OnVerify(this.email, this.password);
}

class RegisterValidate extends RegisterEvent {

}

class RegisterClearState extends RegisterEvent {

}
class OnRegister extends RegisterEvent{
var fname;
var lname;
var email;
var pass;
var tele;
var username;
var gender;

OnRegister(
      this.fname, this.lname, this.email, this.pass, this.tele, this.username,this.gender);
}


class RegisterAuth extends RegisterEvent {
  var fullname;
  var telephone;
  var email;
  var password;

  RegisterAuth({ this.fullname, this.telephone, this.email, this.password });
}

