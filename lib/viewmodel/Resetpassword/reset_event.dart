part of 'reset_bloc.dart';

@immutable
abstract class ResetEvent {



}
class SendCode extends ResetEvent {

  var email;

  SendCode({this.email});
}

class SendVerifyCode extends ResetEvent {
  var email;
  var code;

  SendVerifyCode({this.code,this.email});
}

class ResendVerifyCode  extends ResetEvent {
  var email;

  ResendVerifyCode({this.email});
}
class SendResetPassword extends ResetEvent {
  var email;
  var password;

  SendResetPassword(this.email, this.password);
}


