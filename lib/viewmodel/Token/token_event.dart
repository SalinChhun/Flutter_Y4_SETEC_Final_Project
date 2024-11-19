part of 'token_bloc.dart';


abstract class TokenEvent {


}

class SendTokenAuthorize extends TokenEvent {
  var email;
  var pass;
  SendTokenAuthorize({email,pass});

}

class VerifyTokenUser extends TokenEvent {

  VerifyTokenUser();

}

class RefreshToken extends TokenEvent {
        var refreshtoken;

        RefreshToken(this.refreshtoken);
}