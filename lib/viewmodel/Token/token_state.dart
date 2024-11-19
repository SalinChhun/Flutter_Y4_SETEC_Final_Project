part of 'token_bloc.dart';


abstract class TokenState {}

class TokenInitial extends TokenState {

}
class TokenLoading extends TokenState {

}class TokenVerify extends TokenState {
  TokenModel? tokenModel ;

  TokenVerify({this.tokenModel});
}class TokenError extends TokenState {

}class TokenUnauthorize extends TokenState {

}

class CheckTokenInApp extends TokenState {

}

class TokenNoInternet extends TokenState {

}


