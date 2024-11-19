part of 'login_bloc.dart';

abstract class LoginState extends Equatable{}

class LoginInitial extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoginLoading extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginCompleted extends  LoginState {
  TokenModel? token;


  LoginCompleted({this.token});

  @override
  // TODO: implement props
  List< TokenModel?> get props => [token];
}
class LoginUnAuthorize  extends  LoginState {



  LoginUnAuthorize();

  @override
  // TODO: implement props
  List< TokenModel?> get props => [];
}
class LoginError extends LoginState {
  var error;

  LoginError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
