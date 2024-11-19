part of 'reset_bloc.dart';

@immutable
abstract class ResetState {}

class ResetInitial extends ResetState {


}

class ResetVerifyCodeLoading extends ResetState {

}


class ResetVerifyCodeSuccess extends ResetState {

}

class ResendCodeSuccess extends ResetState {

}

class ResetVerifyCodeError extends ResetState {

}

class VerifyCodeLoading extends ResetState {

}


class VerifyCodeAuthorize extends ResetState {

}
class UnAuthorizeCode extends ResetState {

}
class VerifyCodeError extends ResetState {

}

class ResetPasswordLoading extends ResetState {

}


class ResetPasswordSccess extends ResetState {

}

class ResetPasswordError extends ResetState {

}